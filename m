From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Jun 2016 11:48:11 +0100
Subject: v4.7-rc2 kernel fails to boot when acpi=force
In-Reply-To: <38f33112-e65f-85f0-d6ab-a0af12444fb0@riken.jp>
References: <125b057c-647b-9db7-11b4-4b7123e4b80a@riken.jp>
 <20160607102317.GC2633@leverpostej>
 <7faf36bf-00d9-fb37-381a-6324d1dba977@riken.jp>
 <20160607110540.GD2633@leverpostej>
 <70463161-1d59-a7ad-09c4-c4c7dd68d1ab@riken.jp>
 <20160608094733.GA14506@leverpostej>
 <38f33112-e65f-85f0-d6ab-a0af12444fb0@riken.jp>
Message-ID: <20160608104811.GB14506@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 07:07:26PM +0900, Itaru Kitayama wrote:
> 
> On 6/8/16 6:47 PM, Mark Rutland wrote:
> >
> >It looks like the we're failing to find the console (judging by the fact
> >the kernel opted to use a dummy device). The other messages look largely
> >fine. It may be worth also passing "keep_bootcon" to try to get a few
> >more lines of messages, though that may or may not be helpful.
> 
> I tried that and actually I obtained a lot longer boot log, I will
> past it below after answering your questions.
> 
> >I was under the impression that SPCR told us the console to use, but
> >from grepping the kernel source code, it looks like mainline doesn't
> >support that yet. Given that, I'm at a loss as to how this could have
> >worked for v4.6.
> >
> >I take it you've used the exactly same command line for v4.6 and
> >v4.7-rc2? i.e. you weren't previously passing something like
> >"console=ttyAMA0,115200"?
> 
> I doubt I was, but as I've reinstalled the system there's no way
> to confirm.
> 
> >Were you using a vanilla v4.6? Or some distro derivative?
> 
> It was a vanilla v4.6.

Ok.

I just had a go booting a v4.6 kernel (defconfig + CONFIG_EXPERT to
enable the relevant ACPI options) on a Seattle system. I passed
"acpi=force", but avoided "console=". 

The last messages I see form my kernel are also:

[    0.008104] Console: colour dummy device 80x25
[    0.012572] console [tty0] enabled
[    0.015989] bootconsole [pl11] disabled

If I also pass "console=ttyAMA0,115200", I get a full set of messages,
including a i2c-designware-core warnign similarly to what you saw below
for v4.7-rc2.

So I suspect previously, something was passing an option like
"console=ttyAMA0,115200" to the kernel.

Thanks,
Mark.
