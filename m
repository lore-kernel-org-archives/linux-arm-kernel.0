From: pwaechtler@mac.com (Peter =?iso-8859-1?q?W=E4chtler?=)
Date: Wed, 13 Apr 2011 08:51:16 +0200
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
Message-ID: <201104130851.17676.pwaechtler@mac.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 12. April 2011, 21:20:14 schrieb Andrei Warkentin:
> Hi Peter,
> 
> 2011/4/12 Peter W?chtler <pwaechtler@mac.com>:
> > Hello Linux ARM developers,
> > 
> > did the ARM Linux 2.6 kernel map the kernel memory in pages in the past?
> > Or was the memory always mapped in sections?
> > 
> > I still have to chase a potential memory corruption. The rootfs is
> > located on a SDcard and gets corrupted even when the filesystem test
> > programs write to different partitions.
> > The test scenario includes several dozen or even hundreds of warm and
> > cold boot sequences, file system write tests with sudden soft resets.
> > It's a large embedded project with a lot of drivers and the fact that
> > always the rootfs and often the superblock gets damaged let me think of
> > a memory corruption.
> 
> Sorry, I don't want to be obvious, but you mentioned sudden resets
> while writing, which is almost always going to wind
> up as fs corruptions, with the severity depending on the level of
> caching the system is doing to the writes.
> How are you mounting your rootfs and what file system are you using?
> What sort of corruptions to the super block are you seeing?
> 

It's using ext4 with metadata journalling in ordered mode.
I had to check "if it's the FS" - the test programs create lots of directories 
and files while a timer is armed to issue a soft reset.
The partitions where the "stress tests" run on - survive it happily - just the 
rootfs where almost nothing gets written is severly damaged so that fsck.ext4 
will not repair it automatically.

I experiment with mounting rootfs as readonly, without a journal - and get 
hard to interpret results. The superblock gets written on a "mount -o 
remount,ro", the superblock of the journal gets hit and directories, inode 
bitmaps gets "thrashed". All on the file system where the actual tests do NOT 
run.
In the past I tried to write patterns onto the blocks without file system to 
check if the sdio device mangles some blocks - no it didn't.

I created a slab to move the superblock away from it's "old" memory location - 
the super block was not damaged anymore. Now I want to stop experimenting and 
want to get a nice panic where I see the root cause.
But it can be still devices issuing wrong dma transfers ;(

  Peter  
