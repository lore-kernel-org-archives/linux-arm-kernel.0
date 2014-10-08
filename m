From: balbi@ti.com (Felipe Balbi)
Date: Wed, 8 Oct 2014 12:57:07 -0500
Subject: RCU bug with v3.17-rc3 ?
In-Reply-To: <20141008171322.GH22688@saruman>
References: <20140904184021.GA13421@saruman.home>
 <20140904191642.GJ5001@linux.vnet.ibm.com>
 <20140904192535.GJ13421@saruman.home>
 <20140904200403.GL13421@saruman.home>
 <20140905213216.GD5001@linux.vnet.ibm.com>
 <20141008171322.GH22688@saruman>
Message-ID: <20141008175707.GI22688@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 08, 2014 at 12:13:22PM -0500, Felipe Balbi wrote:
> On Fri, Sep 05, 2014 at 02:32:16PM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 04, 2014 at 03:04:03PM -0500, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Thu, Sep 04, 2014 at 02:25:35PM -0500, Felipe Balbi wrote:
> > > > On Thu, Sep 04, 2014 at 12:16:42PM -0700, Paul E. McKenney wrote:
> > > > > On Thu, Sep 04, 2014 at 01:40:21PM -0500, Felipe Balbi wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > I keep triggering the following Oops with -rc3 when writing to the mass
> > > > > > storage gadget driver:
> > > > > 
> > > > > v3.17-rc3, correct?
> > > > 
> > > > yup, as in subject ;-)
> > > > 
> > > > > I take it that the test passes on some earlier version?
> > > > 
> > > > about to test v3.14.17.
> > > 
> > > coudln't get v3.14 working on this board but at least v3.16 is also
> > > affected except that on now it happened during boot, I didn't even need
> > > to run my test:
> > > 
> > > [   17.438195] Unable to handle kernel paging request at virtual address ffffffff
> > > [   17.446109] pgd = ec360000
> > > [   17.448947] [ffffffff] *pgd=ae7f6821, *pte=00000000, *ppte=00000000
> > > [   17.455639] Internal error: Oops: 17 [#1] SMP ARM
> > > [   17.460578] Modules linked in: dwc3(+) udc_core lis3lv02d_i2c lis3lv02d input_polldev dwc3_omap matrix_keypad
> > > [   17.471060] CPU: 0 PID: 1381 Comm: accounts-daemon Tainted: G W     3.16.0-00005-g8a6cdb4 #811
> > > [   17.480735] task: ed716040 ti: ec026000 task.ti: ec026000
> > > [   17.486405] PC is at find_get_entry+0x7c/0x128
> > > [   17.491070] LR is at 0xfffffffa
> > > [   17.494364] pc : [<c0110b4c>]    lr : [<fffffffa>]    psr: a0000013
> > > [   17.494364] sp : ec027dc8  ip : 00000000  fp : ec027dfc
> > > [   17.506384] r10: c0c6f6bc  r9 : 00000005  r8 : ecdf22f8
> > > [   17.511860] r7 : ec026008  r6 : 00000001  r5 : 00000000  r4 : 00000000
> > > [   17.518705] r3 : ec027db4  r2 : 00000000  r1 : 00000005  r0 : ffffffff
> > > [   17.525526] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM Segment user
> > > [   17.533007] Control: 10c5387d  Table: ac360059  DAC: 00000015
> > > [   17.539020] Process accounts-daemon (pid: 1381, stack limit = 0xec026248)
> > > [   17.546151] Stack: (0xec027dc8 to 0xec028000)
> > > [   17.550710] 7dc0:                   00000000 00000000 c0110ad0 ecdf0b80 00000000 ecdf22f4
> > > [   17.559259] 7de0: ecdf22f4 00000000 00000005 00000000 ec027e34 ec027e00 c0111874 c0110adc
> > > [   17.567824] 7e00: ecdf0b80 c03565b4 ed7165f8 ec3dddf0 ecdf22f4 00000005 ec3ddd00 00000001
> > > [   17.576385] 7e20: ecdf21a0 00000000 ec027ebc ec027e38 c0112978 c0111844 00000000 c06af938
> > > [   17.584950] 7e40: ecdf0b70 ecdf0b70 ec027e6c ec027e58 00000005 00000006 00000b80 ecdf0b70
> > > [   17.593514] 7e60: 00000000 c0163264 ec3dddf0 ec027ee8 ec027ed4 00000b80 ec027eac ec027e88
> > > [   17.602087] 7e80: c0178d98 c0356590 00000000 00000000 00020000 00005b80 00000000 ec027f78
> > > [   17.610653] 7ea0: ec3ddd00 ed716040 b6cab018 00000000 ec027f44 ec027ec0 c0163264 c0112780
> > > [   17.619202] 7ec0: 00000180 00000180 ec027efc b6cab018 00000180 00000000 00000000 00000180
> > > [   17.627772] 7ee0: ec027ecc 00000001 ec3ddd00 00000000 00000000 00000000 ed716040 00000000
> > > [   17.636371] 7f00: 00000000 00000000 00005b80 00000000 00000180 00000000 00000000 00000000
> > > [   17.644946] 7f20: b6cab018 ec3ddd00 b6cab018 ec027f78 ec3ddd00 00000180 ec027f74 ec027f48
> > > [   17.653524] 7f40: c0163a6c c01631cc b6cab018 00000000 00005b80 00000000 ec3ddd03 ec3ddd00
> > > [   17.662085] 7f60: 00000180 b6cab018 ec027fa4 ec027f78 c0164198 c01639e0 00005b80 00000000
> > > [   17.670658] 7f80: be91badc be91ba50 00044a00 00000003 c000f044 ec026000 00000000 ec027fa8
> > > [   17.679222] 7fa0: c000edc0 c0164158 be91badc be91ba50 00000008 b6cab018 00000180 be91ba38
> > > [   17.687794] 7fc0: be91badc be91ba50 00044a00 00000003 be91bbac b6cab008 00000000 00000000
> > > [   17.696370] 7fe0: 00000020 be91ba40 b6c78e8c b6c78ea8 60000010 00000008 ae7f6821 ae7f6c21
> > > [   17.704956] [<c0110b4c>] (find_get_entry) from [<c0111874>] (pagecache_get_page+0x3c/0x1f4)
> > > [   17.713687] [<c0111874>] (pagecache_get_page) from [<c0112978>] (generic_file_read_iter+0x204/0x794)
> > > [   17.723259] [<c0112978>] (generic_file_read_iter) from [<c0163264>] (new_sync_read+0xa4/0xcc)
> > > [   17.732185] [<c0163264>] (new_sync_read) from [<c0163a6c>] (vfs_read+0x98/0x158)
> > > [   17.739945] [<c0163a6c>] (vfs_read) from [<c0164198>] (SyS_read+0x4c/0xa0)
> > > [   17.747149] [<c0164198>] (SyS_read) from [<c000edc0>] (ret_fast_syscall+0x0/0x48)
> > > [   17.754994] Code: e1a01009 eb08ffa9 e3500000 0a00001f (e5904000) 
> > > [   17.761476] ---[ end trace 49c4ed35a1c01157 ]---
> > > 
> > > It seems to be a difficult-to-reproduce race though. On a second boot it
> > > didn't die during boot, but died with my USB test case. Unfortunately,
> > > the platform I'm using is pretty new and only goes as far back as v3.16
> > > (which I had to backport 11 patches to get it to boot good enough for
> > > this test).
> > > 
> > > I wonder if a corrupt file system could cause such problems... I keep
> > > seeing EXT4 errors every now and again; considering that this dies in a
> > > path through VFS, I wonder...
> > 
> > I recall hearing of similar things in the past, but must defer to the
> > FS/VFS experts on this one.
> 
> resurrecting this thread. I'm facing the same issues with a brand new
> filesystem mounted through NFS. The way to reproduce is the same though:
> using g_mass_storage with either tmpfs or mmc as backing store.
> 
> However it seems to die much more frequently than before. I can
> reproduce all the time. It's definitely not a problem with my board as I
> have two boards with different SoCs (ARM Cortex A8 and ARM Cortex A9)
> with two different USB peripheral controllers (MUSB and DWC3), using the
> same rootfs and they die the exact same way no matter if I use tmpfs or
> MMC as backing store.
> 
> Adding a few more folks here.

alright, first stable kernel with Cortex A8 was v3.14. All other kernel
versions die starting with v3.15 to today's Linus. I'll start bisecting
now.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141008/1bd4007e/attachment.sig>
