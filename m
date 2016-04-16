From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Apr 2016 17:26:47 -0700
Subject: [PATCH v2 4/9] remoteproc: Introduce Qualcomm WCNSS firmware
 loader
In-Reply-To: <CALAqxLU1wo1kX752q6tx1j+2b5VR7DnFBKGPm23D5c-gdLTd7A@mail.gmail.com>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
 <1459222625-11440-5-git-send-email-bjorn.andersson@linaro.org>
 <CALAqxLU1wo1kX752q6tx1j+2b5VR7DnFBKGPm23D5c-gdLTd7A@mail.gmail.com>
Message-ID: <20160416002647.GA391@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 15 Apr 13:17 PDT 2016, John Stultz wrote:

> On Mon, Mar 28, 2016 at 8:37 PM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> >
> > This introduces the peripheral image loader, for loading WCNSS firmware
> > and boot the core on e.g. MSM8974. The firmware is verified and booted
> > with the help of the Peripheral Authentication System (PAS) in
> > TrustZone.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Changes since v1:
> > - Split iris definition into separate driver/dt-node
> > - Move constants from DT to code
> > - Make stop-state and some of interrupts optional to properly work on 8064
> > - Cleaned up and made mdt loader support relocation, which is needed on 8016.
> 
> Hey Bjorn,
>     As you know,  I've been successfully using this patchset along
> with a number of other patches in your trees to get wifi working on
> the 2013 Nexus7. So for that, this can get a Tested-by: John Stultz
> <john.stultz@linaro.org> :)
> 

Thanks!

> Though while I don't have much feedback on this specific driver, I am
> a little curious about how the bigger integrated picture should look.
> 
> Currently, after bootup, one must "echo start >
> /sys/kernel/debug/remoteproc/remoteproc0/state" to actually boot the
> remote processor.
> 
> One issue is that if I try to integrate that line into some of the
> bootup scripts, the system will hard hang. No panic, no OOPs, no
> watchdog reboot, just a full device lockup. So it seems like there
> needs to be some checks to ensure that whatever clks or otherhardware
> is needed are up and running.
> 

I do see a similar problem on 8974, if I enable "clock scaling" on the
RPM. My guess here is that while booting the WCNSS firmware it releases
some clock that we have not voted for, which makes the RPM pull the
carpet underneath us.

> Second, after booting when I do "echo start..." manually, on occasion
> I run into the case where while we're waiting for the firmware to
> finish loading and the remote proc to come up, wpa_supplicant kicks in
> and starts the wcnss driver, which tries to load the configuration
> firmware before the remoteproc is all the way up. This fails, and then
> usually a few seconds later there's a bad pointer traversal that
> Oopses the machine (dmesg log below)
> 

There are two cases I've seen this:
1) When the WLAN driver starts communicating with the WLAN part of the
firmware before the WCNSS part has informed us about it being fully
booted (and have accepted the NV).

2) When not being patient enough on the first message sent (after
passing #1).


I redesigned the solution to not probe the wifi (and bt) drivers before
we get the indication from the wcnss firmware, I believe that's what
you're running. So #1 should not be causing this.

I have not seen any additional handling for #2 in the downstream driver,
so perhaps we should just bump the timeout and accept that it's going to
take some time for the firmware to get ready. But further archaeological
efforts are needed to conclude this.

> This is clearly racy, and I wonder if the starting of the remoteproc
> is something that should be done by the wcnss driver which depends on
> it?  Though I'm not sure how this would be integrated.
> 

The race should be handled regardless.

But the question of who actually triggers the booting of the wifi
system is still an open one. All executing parts of the wcnss and wifi
driver follows the life cycle of the remote services, i.e. follows the
remoteproc life cycle - so they can't request the system to boot.

We could design it so that the life cycle follows module_init/exit of
the wcnss driver, but that's clunky and as we don't have the firmware
available until later during boot this requires us to have these as
modules (or figure out how to get async firmware loading that waits for
the partition to be mounted).


In the downstream kernel we can see a few different solutions:
- The wireless subsystem comes to life when you touch /dev/wlan, and I
  don't think you can shut it down.
- The application DSP has followed a few different models, one being
  tied 1:1 with a kernel module for the specific purpose of booting and
  stopping the core.
- The video coprocessor, follows the life cycle of the v4l driver - so
  that should be fine - except for the firmware not being available at
  probe time, so we're back at loading from a future file system.
- The modem is booted when a certain QMI service is being looked for.


In the Android case we could use the HALs and some reference counting to
keep the other CPUs running, but in a normal Linux system we don't have
something like this.

So this is still an open issue, that we have to spend more time on.

> thanks
> -john
> 
> 
> "echo start..." happened here...
> 
> [   46.719340]  remoteproc0: powering up 3204000.wcnss-rproc
> [   46.719486]  remoteproc0: Booting fw image wcnss.mdt, size 6804
> [   47.307160] qcom_wcnss_ctrl riva.wcnss: WCNSS Version 1.4 1.2
> [   47.321853] wcn36xx: mac address: 18:00:2d:88:9c:a9

Hey, that's my MAC address ;)

> 
> But, before loading is finished, wpa_supplicant starts up...
> 
> [   47.403815] init: Starting service 'wpa_supplicant'...
> [   47.749631] wcn36xx smd:riva at 6:wcnss:wifi: loading
> /system/vendor/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin failed with
> error -13
> [   47.749824] wcn36xx smd:riva at 6:wcnss:wifi: Direct firmware load for
> wlan/prima/WCNSS_qcom_wlan_nv.bin failed with error -2
> [   47.749841] wcn36xx smd:riva at 6:wcnss:wifi: Falling back to user helper
> 
> (Note, this firmware load error above happens normally, and the
> userhelper usually has to save the day, this is probably a separate
> issue with the wcn36xx patches I'm using, and not an issue  with the
> remoteproc code)
> 

Yeah, I've seen some of that too. As you say it's unrelated, but we
should look into making this not shooting odd error messages at people.

> [   48.246701] wcn36xx: ERROR Timeout! No SMD response in 500ms
> [   48.246752] wcn36xx: ERROR Failed to push NV to chip
> [   48.268973] init: Service 'wpa_supplicant' (pid 1170) exited with status 255
> [   51.858442]  remoteproc0: remote processor 3204000.wcnss-rproc is now up
> [   67.543147] init: Starting service 'wpa_supplicant'...
> [   67.877434] wcn36xx: ERROR hal_load_nv response failed err=5

Hmm, 5...

I have not seen that since I figured out how to properly calibrate the
XO before booting the firmware. I'll replicate your setup and will see
if I can trigger this.

> [   67.877443] wcn36xx: ERROR Failed to push NV to chip
> [   67.891921] init: Service 'wpa_supplicant' (pid 1175) exited with status 255
> [   87.682962] Unable to handle kernel NULL pointer dereference at
> virtual address 00000038
> [   87.683324] pgd = e7d2c000
> [   87.691595] [00000038] *pgd=00000000
> [   87.697486] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [   87.697658] CPU: 3 PID: 159 Comm: lmkd Not tainted
> 4.6.0-rc3-00095-ga08f5eb #1252
> [   87.703041] Hardware name: Qualcomm (Flattened Device Tree)
> [   87.710413] task: e7c69a00 ti: e7d30000 task.ti: e7d30000
> [   87.715798] PC is at kmem_cache_alloc+0x80/0x234
> [   87.721347] LR is at kmem_cache_alloc+0x40/0x234

This seems "unrelated", I wonder if either we or the remote is trashing
some memory when we're triggering this case.

Regards,
Bjorn
