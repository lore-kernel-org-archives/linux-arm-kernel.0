From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 15 Jan 2013 12:00:41 +0200
Subject: [PATCH v5 6/9] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C14311FE538@DFLE08.ent.ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-7-git-send-email-rtivy@ti.com>
 <CAK=WgbZVayi-USPCwB3KSbzRQ_oxatznt4d26A8_GpWmay2daA@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FE538@DFLE08.ent.ti.com>
Message-ID: <CAK=WgbbNygzphujf9df8_qj4e2ddKJ_1OkQzz7-a7e9QuP8idA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Sat, Jan 12, 2013 at 4:26 AM, Tivy, Robert <rtivy@ti.com> wrote:
> Is FW_CONFIG above supposed to be FW_LOADER?

That FW_CONFIG is completely bogus of course. care to fix it in your series?

> We're currently handling the CHIPINT lines as "level"s, since they're completely controlled by SW.  The interruptor raises the line and the interruptee lowers (clears) it.  In a situation where every interrupt is considered to be a signal of new data arrival we need to make sure that the other side has "seen" the previous interrupt before we raise another one.

What if we don't ? Can the DSP side just go over the vrings until no
new msg is left (similar to what you do on the Linux side) ?

> Is this suggesting that there be separate platform device instances for each different potential fw, and that each platform device instance hardcodes the fw filename?

In principle this same driver can drive many instances of remote
processors you may have on your board. E.g. in OMAP the same driver
controls both the M3s and the DSP. pdata is then used to hold
information specific to the hw instance.

I'm not sure if there's (or will be) any DaVinci platform with several
remote processors but it's a better practice to write the code as if
there is/will be - it's usually cleaner and will just work in case a
platform with multiple rprocs does show up one day.

> Sekhar asked that there not be a default fw name, so there's conflicting feedback on this point.  I prefer to have a default name plus the module parameter override (but don't have much opinion on whether it should be davinci-specific (and passed with davinci_remoteproc.ko) or general (and passed with remoteproc.ko), please advise).
>
> Since the fw file (i.e., DSP program) is typically paired with a particular Linux app, I like the ability to specify the fw filename at runtime, depending on the Linux app I need to run.

Sure, no reason why not to allow users to override the default fw name.

Thanks,
Ohad.
