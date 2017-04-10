From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 10 Apr 2017 11:16:34 +0100
Subject: [PATCH v4] arm: Fix memory attribute inconsistencies when using
 fixmap
In-Reply-To: <20170408165100.GA3589@afzalpc>
References: <1491291087-17450-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170405224245.GA17774@n2100.armlinux.org.uk>
 <1491486403.2950.3.camel@linaro.org>
 <CAKv+Gu_EVqqQGXauWmfhhmJZEyrPDEHDiN2T23XVPy_eR99Lsg@mail.gmail.com>
 <1491494594.2950.7.camel@linaro.org> <20170408165100.GA3589@afzalpc>
Message-ID: <1491819394.3172.1.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-04-08 at 22:21 +0530, afzal mohammed wrote:
> Hi,
> 
> On Thu, Apr 06, 2017 at 05:03:14PM +0100, Jon Medhurst (Tixy) wrote:
> > To cope with the variety in ARM architectures and configurations, the
> > pagetable attributes for kernel memory are generated at runtime to match
> > the system the kernel finds itself on. This calculated value is stored
> > in pgprot_kernel.
> > 
> > However, when early fixmap support was added for ARM (commit
> > a5f4c561b3b1) the attributes used for mappings were hard coded because
> > pgprot_kernel is not set up early enough. Unfortunately, when fixmap is
> > used after early boot this means the memory being mapped can have
> > different attributes to existing mappings, potentially leading to
> > unpredictable behaviour. A specific problem also exists due to the hard
> > coded values not include the 'shareable' attribute which means on
> > systems where this matters (e.g. those with multiple CPU clusters) the
> > cache contents for a memory location can become inconsistent between
> > CPUs.
> > 
> > To resolve these issues we change fixmap to use the same memory
> > attributes (from pgprot_kernel) that the rest of the kernel uses. To
> > enable this we need to refactor the initialisation code so
> > build_mem_type_table() is called early enough. Note, that relies on early
> > param parsing for memory type overrides passed via the kernel command
> > line, so we need to make sure this call is still after
> > parse_early_params().
> 
> Tested-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> 
> with an emphasis on no-MMU's

Thanks. I've now submitted this new version to the patch tracker...
http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8667/3
