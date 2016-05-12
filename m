From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 12 May 2016 16:19:48 +0300
Subject: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <4521594.dSmlmmAdFg@wuerfel>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <2733875.IzutTZKHMc@wuerfel> <57347BD4.8010105@huawei.com>
 <4521594.dSmlmmAdFg@wuerfel>
Message-ID: <20160512131948.GA30205@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 03:06:39PM +0200, Arnd Bergmann wrote:
> On Thursday 12 May 2016 20:49:24 Zhangjian wrote:
> > Hi,
> > 
> > On 2016/5/12 17:21, Arnd Bergmann wrote:
> > > On Thursday 12 May 2016 10:17:58 Catalin Marinas wrote:
> > >> On Wed, May 11, 2016 at 09:30:07PM +0200, Arnd Bergmann wrote:
> > >>> On Wednesday 11 May 2016 17:59:01 Catalin Marinas wrote:
> > >>>
> > >>> I don't think the shifts are a problem, the main downside would be
> > >>> the limit to 44 bits of file offsets (16TB files), but it's also
> > >>> unclear if that is a practical problem at all. If it is, we run
> > >>> into the same problem on all other 32-bit architectures too.
> > >>
> > >> I hope people are seriously thinking of moving to an LP64 ABI if they
> > >> have such large file offset needs.
> > >
> > > Good point. 44 bits of file size is certainly enough for mmap()
> > > on a 32-bit task: you would only be able to map a very small fraction
> > > of the file anyway, and if you want to map larger files, and should
> > > move to 64-bit tasks long before this becomes a limitation.
> > Hi,
> > 
> > I apply the following patch in order to make use of the REAL mmmap2. LTP
> > test pass in litle endian. mmap16 successful with segfault in big endian.
> > 
> > BTW, I saw the similar code in tile, mips, microblaze and s390 compat. Should
> > we merge these code into a common syscall wrapper?
> 
> I think that's a good idea. The function used to be slightly different
> for each architecture, but now it seems we have a significant number
> of identical implementations that we could just merge them together
> into one.
> 
> sys_mmap_pgoff was originally introduced as the common implementation
> and it reduced the amount of duplication a lot, but as its units
> are based on PAGE_SIZE rather than hardwired 4096 bytes, it's
> not as useful.
> 

microblaze and mips (twice) are doing like this. And aarh32 as well,
in arch/arm64/kernel/entry32.S

In previous submissions it was a patch that shares aarch32 code to
ilp32. If we decided turn around again, I think, we'd pick up that patch.

The other option is to make this hack generic, as so many arches use it.
