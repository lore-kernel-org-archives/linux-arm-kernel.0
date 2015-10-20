From: panand@redhat.com (Pratyush Anand)
Date: Tue, 20 Oct 2015 14:26:20 +0530
Subject: [PATCH 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
 <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
Message-ID: <20151020085620.GC31893@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

Thanks for the patches.

On 19/10/2015:11:38:53 PM, Geoff Levand wrote:
> +static void soft_restart(unsigned long addr)
> +{
> +	setup_mm_for_reboot();
> +	cpu_soft_restart(virt_to_phys(cpu_reset), addr,
> +		is_hyp_mode_available());

So now we do not flush cache for any memory region. Shouldn't we still flush
at least kernel and purgatory segments. 

kexec-tools loads a new kernel and purgatory executable. Some of those bits
might still be only in D-cache and we disable D-cache before control is passed
to the purgatory binary. Purgatory and some initial part of kernel code is
executed with D-cache disabled. So, We might land into a situation where correct
code is not executed while D-cache is disabled, no?

~Pratyush
