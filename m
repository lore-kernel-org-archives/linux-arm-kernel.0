From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Oct 2017 15:56:09 +0100
Subject: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
In-Reply-To: <20171013144319.GB4746@arm.com>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-8-pasha.tatashin@oracle.com>
 <20171010155619.GA2517@arm.com>
 <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
 <20171010171047.GC2517@arm.com>
 <CAOAebxtrSthSP4NAa0obBbsCK1KZxO+x0w5xNrpY6m2y9UZFvQ@mail.gmail.com>
 <CAOAebxu5WL-FQLgfCxNcWy36V6zsTO1v3LLqXv5rM1Pp9R-=YA@mail.gmail.com>
 <20171013144319.GB4746@arm.com>
Message-ID: <20171013145431.GA5919@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 13, 2017 at 03:43:19PM +0100, Will Deacon wrote:
> On Fri, Oct 13, 2017 at 10:10:09AM -0400, Pavel Tatashin wrote:
> > I am getting the following panic during boot:
> > 
> > [    0.012637] pid_max: default: 32768 minimum: 301
> > [    0.016037] Security Framework initialized
> > [    0.018389] Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
> > [    0.019559] Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
> > [    0.020409] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> > [    0.020721] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
> > [    0.055337] Unable to handle kernel paging request at virtual
> > address ffff0400010065af
> > [    0.055422] Mem abort info:
> > [    0.055518]   Exception class = DABT (current EL), IL = 32 bits
> > [    0.055579]   SET = 0, FnV = 0
> > [    0.055640]   EA = 0, S1PTW = 0
> > [    0.055699] Data abort info:
> > [    0.055762]   ISV = 0, ISS = 0x00000007
> > [    0.055822]   CM = 0, WnR = 0
> > [    0.055966] swapper pgtable: 4k pages, 48-bit VAs, pgd = ffff20000a8f4000
> > [    0.056047] [ffff0400010065af] *pgd=0000000046fe7003,
> > *pud=0000000046fe6003, *pmd=0000000046fe5003, *pte=0000000000000000
> > [    0.056436] Internal error: Oops: 96000007 [#1] PREEMPT SMP
> > [    0.056701] Modules linked in:
> > [    0.056939] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> > 4.14.0-rc4_pt_memset12-00096-gfca5985f860e-dirty #16
> > [    0.057001] Hardware name: linux,dummy-virt (DT)
> > [    0.057084] task: ffff2000099d9000 task.stack: ffff2000099c0000
> > [    0.057275] PC is at __asan_load8+0x34/0xb0
> > [    0.057375] LR is at __d_rehash+0xf0/0x240

Do you know what your physical memory layout looks like? 

Knowing that would tell us where shadow memory *should* be.

Can you share the command line you're using the launch the VM?

Thanks,
Mark.
