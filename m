From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Aug 2015 13:38:00 +0100
Subject: [PATCH 9/9] ARM: software-based priviledged-no-access support
In-Reply-To: <CAMuHMdWCLcDS=64m0J09KJJ4bDtgZ1Yvq8rw7u9FE0vZkKT2cw@mail.gmail.com>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <E1ZSmQG-0002za-E3@rmk-PC.arm.linux.org.uk>
 <CAMuHMdVMka2mt5pFpnXfLRY2M3Sj_71MgEpthOia2C99RaP_DA@mail.gmail.com>
 <20150825104422.GO7557@n2100.arm.linux.org.uk>
 <CAMuHMdWCLcDS=64m0J09KJJ4bDtgZ1Yvq8rw7u9FE0vZkKT2cw@mail.gmail.com>
Message-ID: <20150825123800.GQ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 01:21:04PM +0200, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Tue, Aug 25, 2015 at 12:44 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Aug 25, 2015 at 12:32:51PM +0200, Geert Uytterhoeven wrote:
> >> This patch, which is now in arm-soc/for-next, breaks shmobile_defconfig
> >> on r8a7791/koelsch, which has a dual core CA15:
> >>
> >>     [ ok ] Configuring network interfaces...done.
> >>     Unhandled fault: page domain fault (0x01b) at 0xbe8e6120
> >>     pgd = edbb0000
> >>     [be8e6120] *pgd=6da77831, *pte=bf4d075f, *ppte=bf4d0c7f
> >>     Internal error: : 1b [#1] SMP ARM
> >>     CPU: 1 PID: 1629 Comm: ntpdate Not tainted
> >> 4.2.0-rc8-06444-g3c24fd89c9421db1 #31
> >>     9
> >>     Hardware name: Generic R8A7791 (Flattened Device Tree)
> >>     task: ed883a80 ti: ed41c000 task.ti: ed41c000
> >>     PC is at csum_partial_copy_from_user+0x28/0x3d8
> >>     LR is at csum_and_copy_from_iter+0x334/0x4c0
> >>     pc : [<c04ba510>]    lr : [<c01c82e8>]    psr: 000f0013
> >>     sp : ed41db00  ip : 00000020  fp : ed41db6c
> >>     r10: ed41ddc0  r9 : 00000027  r8 : ed41dc20
> >>     r7 : 00000027  r6 : eda52653  r5 : ed41dec8  r4 : 00000000
> >>     r3 : 00000000  r2 : 00000027  r1 : eda5262c  r0 : be8e6120
> >>     Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> >>     Control: 10c5307d  Table: 6dbb006a  DAC: 00000051
> >>     Process ntpdate (pid: 1629, stack limit = 0xed41c210)
> >
> > Thanks.  I wonder what's different about your ntpdate that triggers
> > this, and why all my iMX6 behave fine, which have desktop-like ubuntu
> > installs on (of two different versions.)
> 
> It's ntpdate 1:4.2.6.p5+dfsg-7 from desktop-like Debian jessie.

Hmm, I think I tried at one time to install Debian on an iMX6 platform
and gave up with it after spending 50 minutes with the installer getting
so far, and then killing the network - it was very repeatable, and always
happened at the same point in the installation.  I gave up with Debian
at that point, as I didn't have lots of 50 minutes to babysit the silly
installer (which can't ask the questions up-front) nor did I want to
waste my monthly internet allowance on multiple failed install attempts.

The reports I was getting from other iMX6 users was that Debian Jessie
had lots of problems at that time.

> But I get similar dumps during boot up from rpc.idmapd (SyS_send),
> rsyslogd (SyS_send), and from sshd (SyS_write) when trying to log in.

Hmm.

root       693  0.0  0.1   4944  3196 ?        Ss   01:22   0:00 /usr/sbin/sshd -D
syslog     720  0.2  0.0  30404  2032 ?        Sl   01:23   1:19 rsyslogd -c5
root       722  0.0  0.0   2392  1340 ?        Ss   01:23   0:00 rpc.idmapd

So, the question I need to find an answer to is... why hasn't this path
been exercised on my platforms during my testing.  It's certainly
compiled into the kernel...

Anyway, I've now (hopefully) fixed the bug, but I've nobbled
csum_partial_copy_from_user to ensure that it will always oops the kernel
if called:

000000b4 <csum_partial_copy_from_user>:
  b4:   ee133f10        mrc     15, 0, r3, cr3, cr0, {0}
  b8:   e92d41fe        push    {r1, r2, r3, r4, r5, r6, r7, r8, lr}
  bc:   e3a03055        mov     r3, #85 ; 0x55
  c0:   ee033f10        mcr     15, 0, r3, cr3, cr0, {0}
  c4:   e7033003        str     r3, [r3, -r3]

and... it doesn't trigger.  I can only assume that this is because the
iMX6 ethernet interface uses TSO (which implies checksum offload), there's
no need to use these csum functions - and that would explain why it never
came up in my local testing.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
