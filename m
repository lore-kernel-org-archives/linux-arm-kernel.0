From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 30 May 2017 21:26:20 -0700
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Switch AXP20x driver from
 module to built-in
In-Reply-To: <20170522074414.3qz2wpw4cs2btkhv@flea.lan> (Maxime Ripard's
 message of "Mon, 22 May 2017 09:44:14 +0200")
References: <937914a68e4e7d6db2d12540cc6253b200978e2d.1486590875.git.rask@formelder.dk>
 <49ad3e66452bd78da7b9e581129f76633c56e609.1486590875.git.rask@formelder.dk>
 <20170210084213.uzf25soh7bl73a6g@lukather>
 <CAOi56cV=UBEFQ6V4LLNrHDaDJgb33mrCA6Z+vj_3VziOpkRcvQ@mail.gmail.com>
 <CAOi56cXLo5LaT8CgfwB991gq+gCv4OY3VNkGWviooq43=6Wayg@mail.gmail.com>
 <20170522074414.3qz2wpw4cs2btkhv@flea.lan>
Message-ID: <m2inkhr6s3.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

> Hi Kevin,
>
> On Thu, May 18, 2017 at 11:59:50AM -0700, Kevin Hilman wrote:
>> On Fri, Mar 17, 2017 at 10:39 AM, Kevin Hilman <khilman@baylibre.com> wrote:
>> > On Fri, Feb 10, 2017 at 12:42 AM, Maxime Ripard
>> > <maxime.ripard@free-electrons.com> wrote:
>> >> On Wed, Feb 08, 2017 at 11:09:31PM +0100, Rask Ingemann Lambertsen wrote:
>> >>> The AXP20X regulator support is currently built as a module, which means
>> >>> it's not available until the root fs has been mounted, but the boot loader
>> >>> might not have enabled the required regulators, so build their drivers
>> >>> into the kernel.
>> >>>
>> >>> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
>> >>
>> >> Queued for 4.12.
>> >
>> > Hello, kernelci.org is reporting boot failures on sun5i-r8-chip in
>> > linux-next[1]  for a few days and with a variety of defconfigs. I
>> > bisected it[2] down to this patch.
>> >
>> > I verified that reverting this patch on top of next-20170310 makes my
>> > chip board boot again.
>> 
>> FYI... this board is still broken in linux-next (and now in mainline),
>> and reverting $SUBJECT patch still makes it work.
>> 
>> Is nobody else using mainline on this board?
>
> I thought about that during the weekend, and it might just be a
> symptom.
>
> The CHIP has brown out issues, especially when you enable the WiFi
> chip, which should happen around the time of the failure when the PMIC
> regulator support is compiled as a module.
>
> We mitigate that in upstream's U-Boot by enabling the two regulators
> for the WiFi chip in U-boot, which levels a bit the current over the
> boot.

How recent of a mainline u-boot do I need?  I'm currently running
v2016.01.

> You have a few ways to prevent that from happening. Having a better
> power supply / cable will help, I'm not sure how reasonable that is.
>
> Another thing that can work is, if your USB plugs can take it, to
> increase the overcurrent trigger in the PMIC, ideally in U-Boot.
>
> The last, and probably cleaner one, would be to just power it through
> the 5v input on its header, and not the USB. There's not current
> limitation there, so it shouldn't cause any problems anymore.

OK, I can look into powering via 5V input also.

Just curious: which of the above methods are you using?

Kevin
