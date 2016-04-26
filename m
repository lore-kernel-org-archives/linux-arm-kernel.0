From: prime.zeng@hisilicon.com (Zengtao (B))
Date: Tue, 26 Apr 2016 02:21:16 +0000
Subject: [PATCH] arm64: fix /proc/cpuinfo for elf32
In-Reply-To: <20160425091239.GB9614@e104818-lin.cambridge.arm.com>
References: <1461555453-60440-1-git-send-email-prime.zeng@huawei.com>
 <20160425091239.GB9614@e104818-lin.cambridge.arm.com>
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0A6E6FB7@SZXEMA509-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Monday, April 25, 2016 5:13 PM
> To: Zengtao (B)
> Cc: will.deacon at arm.com; mark.rutland at arm.com; yang.shi at linaro.org;
> suzuki.poulose at arm.com; linux-kernel at vger.kernel.org;
> james.morse at arm.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] arm64: fix /proc/cpuinfo for elf32
> 
> On Mon, Apr 25, 2016 at 11:37:33AM +0800, Zeng Tao wrote:
> > For elf32 thread, personality is used for arm32,
> > and thread_flag for arm64.
> >
> > Here personality is used for arm64, so fix it.
> >
> > Signed-off-by: Zeng Tao <prime.zeng@huawei.com>
> > ---
> >  arch/arm64/kernel/cpuinfo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> > index 84c8684..f739398 100644
> > --- a/arch/arm64/kernel/cpuinfo.c
> > +++ b/arch/arm64/kernel/cpuinfo.c
> > @@ -126,7 +126,7 @@ static int c_show(struct seq_file *m, void *v)
> >  		 * software which does already (at least for 32-bit).
> >  		 */
> >  		seq_puts(m, "Features\t:");
> > -		if (personality(current->personality) == PER_LINUX32) {
> > +		if (test_thread_flag(TIF_32BIT)) {
> >  #ifdef CONFIG_COMPAT
> >  			for (j = 0; compat_hwcap_str[j]; j++)
> >  				if (compat_elf_hwcap & (1 << j))
> 
> We discussed this some time ago and we decided against it. One reason
> was scripts where you may or may not end up with the desired cpuinfo
> (e.g. grep being 64-bit invoked by a 32-bit bash). The personality at
> least is inherited by child processes.

So you mean the 64-bit grep should see the same cpuinfo as its father process
which is 32-bit?

For 32-bit process running on 64-bit kernel, we have to explicitly call the personality 
syscall to get the right cpuinfo, but how to deal with the old 32-bit binaries? 
 

> 
> --
> Catalin
