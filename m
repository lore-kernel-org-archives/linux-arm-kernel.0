From: Bharat.Bhushan@freescale.com (Bharat.Bhushan at freescale.com)
Date: Thu, 6 Mar 2014 09:33:45 +0000
Subject: [PATCH] ARM64: Kernel managed pages are only flushed
In-Reply-To: <20140306065339.GA2975@localhost>
References: <1394018446-16738-1-git-send-email-Bharat.Bhushan@freescale.com>
 <20140306065339.GA2975@localhost>
Message-ID: <f71a1a7ec3a34a5a9ec4e28d7f19c5ec@BN1PR03MB266.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at gmail.com] On Behalf Of Catalin
> Marinas
> Sent: Thursday, March 06, 2014 12:24 PM
> To: Bhushan Bharat-R65777
> Cc: will.deacon at arm.com; linux-arm-kernel at lists.infradead.org; Bhushan Bharat-
> R65777
> Subject: Re: [PATCH] ARM64: Kernel managed pages are only flushed
> 
> On Wed, Mar 05, 2014 at 04:50:46PM +0530, Bharat Bhushan wrote:
> > Kernel can only access pages which maps to managed memory.
> > So flush only valid kernel pages.
> >
> > I observed kernel crash direct assigning a device using VFIO and found
> > that it was caused because of accessing invalid page
> 
> I don't get this. Could you please share some kernel crash message to see the
> backtrace? The __sync_icache_dcache() function is called from
> set_pte_at() if the pte is valid, user and exec. If these are correct, why does
> it crash? Actually, does the cache maintenance crash or page_mapping()?

It fails in page_mapping() because it access page of non-kernel visible memory. I am not a memory management expert and according to my understanding there can be valid pte but may not a valid struct page. Valid struct page exists only for kernel managed memory.


Kernel crash dump (address 0x80c6a0, size: 0x1000; This is the physical address of a device which I am direct assigning to userspace application named Layerscape using VFIO):

Unable to handle kernel paging request at virtual address ffffffbc1c2b7308
pgd = ffffffc0595ea000
[ffffffbc1c2b7308] *pgd=0000000000000000
Internal error: Oops: 96000006 [#1]
Modules linked in:
CPU: 0 PID: 656 Comm: layerscape Not tainted 3.12.0+ #66
task: ffffffc059566e80 ti: ffffffc059294000 task.ti: ffffffc059294000
PC is at page_mapping+0x0/0x14
LR is at __sync_icache_dcache+0x2c/0xb8
pc : [<ffffffc0000f9cac>] lr : [<ffffffc000090554>] pstate: 60000145
sp : ffffffc059297bc0
x29: ffffffc059297bc0 x28: 0000007fb5cce000 
x27: 0000000000000041 x26: 0020000000000c43 
x25: 0000007fb5ccf000 x24: ffffffc0595b0670 
x23: 000000000080c6a0 x22: 002000080c6a0c43 
x21: 012000080c6a0c43 x20: 0000007fb5ccf000 
x19: ffffffbc1c2b7300 x18: 0000007fd7b45500 
x17: 0000000000412268 x16: 0000000000000004 
x15: 0000000000000002 x14: 0000000000000000 
x13: 0000000000003958 x12: 0000000000000048 
x11: 0000000000000013 x10: 00000000000000f0 
x9 : 0000000000000002 x8 : 0000007fb5ece000 
x7 : 0000000000000028 x6 : ffffffc00051b590 
x5 : 0000000000000670 x4 : 0020000000000c43 
x3 : ffffffc000000000 x2 : ffffffc0595b0000 
x1 : ffffffbc00000000 x0 : ffffffbc1c2b7300 
Process layerscape (pid: 656, stack limit = 0xffffffc059294058)
Stack: (0xffffffc059297bc0 to 0xffffffc059298000)
7bc0: 59297be0 ffffffc0 00102510 ffffffc0 59766d70 ffffffc0 ffffffc8 00000000
7be0: 59297c70 ffffffc0 002b51fc ffffffc0 595fd2c0 ffffffc0 596e78d8 ffffffc0
7c00: 00001000 00000000 0c6a0000 00000008 5969c4f8 ffffffc0 00000001 00000000
7c20: 595b1a00 ffffffc0 00000000 00000000 0047e558 ffffffc0 0047e548 ffffffc0
7c40: 59cff080 ffffffc0 b5ccefff 0000007f b5ccf000 0000007f 595eaff0 ffffffc0
7c60: f88569d2 ffffffff b5ccefff 0000007f 59297d00 ffffffc0 002b1cc4 ffffffc0
7c80: 595fd448 ffffffc0 b5cce000 0000007f 595fd440 ffffffc0 00000001 00000000
7ca0: 000000ff 00000000 59294000 ffffffc0 59cff080 ffffffc0 00000000 00000000
7cc0: 00000000 00000000 595fd420 ffffffc0 59297ce0 ffffffc0 595b1000 ffffffc0
7ce0: 0c6a1000 00000008 00001000 00000000 0047e5a0 ffffffc0 0047e580 ffffffc0
7d00: 59297d20 ffffffc0 00108968 ffffffc0 00000000 00000000 00000001 00000000
7d20: 59297da0 ffffffc0 00108e34 ffffffc0 00000007 00000000 000000ff 00000000
7d40: 595d36c0 ffffffc0 00000001 00000000 59cff080 ffffffc0 00001000 00000000
7d60: 00000001 00000000 b5cce000 0000007f 00000007 00000000 59294000 ffffffc0
7d80: 00000007 00000000 595fd2c0 ffffffc0 0080c6a0 00000000 595d36c0 ffffffc0
7da0: 59297e10 ffffffc0 000f9c40 ffffffc0 59cff0d8 ffffffc0 595d36c0 ffffffc0
7dc0: 00000000 00000000 0080c6a0 00000000 595d36c0 ffffffc0 00000015 00000000
7de0: 00000112 00000000 000000de 00000000 004ed000 ffffffc0 000f9c20 ffffffc0
7e00: 59297e68 ffffffc0 0080c6a0 00000000 59297e70 ffffffc0 00107508 ffffffc0
7e20: 00000001 00000000 00001000 00000000 59297e80 ffffffc0 0080c6a0 00000000
7e40: 00000001 00000000 00000003 00000000 00001000 00000000 00000000 00000000
7e60: 60000000 00000000 00000000 00000000 59297ec0 ffffffc0 00086d80 ffffffc0
7e80: 00000000 00000000 00000000 00000000 ffffffff ffffffff b5c2355c 0000007f
7ea0: 80000000 00000000 b5c1ffcc 0000007f 80000000 00000000 00000003 00000000
7ec0: d7b45720 0000007f 000839ec ffffffc0 00000000 00000000 00001000 00000000
7ee0: 00000003 00000000 00000001 00000000 00000005 00000000 0c6a0000 00000008
7f00: 00401884 00000000 00000000 00000000 000000de 00000000 b5ca35d0 0000007f
7f20: ffffffff 00000000 00000008 00000000 00000038 00000000 ffffffff ffffffff
7f40: 00000040 00000000 b5cd3028 0000007f b5c23548 0000007f 00412268 00000000
7f60: d7b45500 0000007f 00000000 00000000 00000000 00000000 004008c0 00000000
7f80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fa0: 00000000 00000000 00000000 00000000 00000000 00000000 d7b45720 0000007f
7fc0: 00400e38 00000000 d7b45720 0000007f b5c2355c 0000007f 80000000 00000000
7fe0: 00000000 00000000 000000de 00000000 00000000 00000000 00000000 00000000
Call trace:
[<ffffffc0000f9cac>] page_mapping+0x0/0x14
[<ffffffc000102510>] remap_pfn_range+0x1cc/0x324
[<ffffffc0002b51fc>] vfio_layerscape_mmap+0x22c/0x248
[<ffffffc0002b1cc4>] vfio_device_fops_mmap+0x20/0x30
[<ffffffc000108968>] mmap_region+0x320/0x538
[<ffffffc000108e34>] do_mmap_pgoff+0x2b4/0x320
[<ffffffc0000f9c40>] vm_mmap_pgoff+0x60/0x90
[<ffffffc000107508>] SyS_mmap_pgoff+0x88/0xc4
[<ffffffc000086d80>] sys_mmap+0x18/0x28
Code: a8c17bfd d65f03c0 928002a0 17fffffd (f9400400) 
---[ end trace 650769ec4955b30e ]---

> 
> --
> Catalin
> 
