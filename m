From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Aug 2014 19:11:06 +0100
Subject: Suspend/resume broken on mx5/mx6 running 4.16
In-Reply-To: <CAOMZO5BN9H-4__2s9yyGiuOBsLO0gf9LOQ0_N1552P8LWJTxCg@mail.gmail.com>
References: <CAOMZO5BN9H-4__2s9yyGiuOBsLO0gf9LOQ0_N1552P8LWJTxCg@mail.gmail.com>
Message-ID: <20140804181106.GI30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 02:53:42PM -0300, Fabio Estevam wrote:
> Unable to handle kernel NULL pointer dereference at virtual address 0000002c
> pgd = bcd14000
> [0000002c] *pgd=4d9e0831, *pte=00000000, *ppte=00000000
> Internal error: Oops: 17 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 617 Comm: sh Not tainted 3.16.0 #17
> task: bc0c4e00 ti: bceb6000 task.ti: bceb6000
> PC is at fec_suspend+0x10/0x70
> LR is at dpm_run_callback.isra.7+0x34/0x6c
> pc : [<803f8a98>]    lr : [<80361f44>]    psr: 600f0013
> sp : bceb7d70  ip : bceb7d88  fp : bceb7d84
> r10: 8091523c  r9 : 00000000  r8 : bd88f478
> r7 : 803f8a88  r6 : 81165988  r5 : 00000000  r4 : 00000000
> r3 : 00000000  r2 : 00000000  r1 : bd88f478  r0 : bd88f478

Right, so the code which oopsed was:

   0:   e1a0c00d        mov     ip, sp
   4:   e92dd818        push    {r3, r4, fp, ip, lr, pc}
   8:   e24cb004        sub     fp, ip, #4
   c:   e5904088        ldr     r4, [r0, #136]  ; 0x88
  10:   e594302c        ldr     r3, [r4, #44]   ; 0x2c

and from the above, we can see that r4 was NULL.

fec_suspend(struct device *dev)
{
        struct net_device *ndev = dev_get_drvdata(dev);

which would make ndev NULL.  I don't see how that could happen though,
as we set the driver data in the probe function.  Any patches on top of
3.16?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
