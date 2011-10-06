From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Oct 2011 17:35:20 +0100
Subject: [RFC/PATCH 1/7] ARM: ARM11 MPCore: pgd_alloc is not preempt safe
In-Reply-To: <1317877714-11355-2-git-send-email-gdavis@mvista.com>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
	<1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317877714-11355-2-git-send-email-gdavis@mvista.com>
Message-ID: <20111006163520.GA21464@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2011 at 01:08:28AM -0400, gdavis at mvista.com wrote:
> @@ -31,6 +32,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>  	if (!new_pgd)
>  		goto no_pgd;
>  
> +	if (cache_ops_need_broadcast())
> +		get_cpu();

Is there something wrong with preempt_disable() here and preempt_enable()
below?  If it's preempt that we're concerned about, these are the correct
interfaces to be used.

> +
>  	memset(new_pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
>  
>  	/*
> @@ -42,6 +46,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>  
>  	clean_dcache_area(new_pgd, PTRS_PER_PGD * sizeof(pgd_t));
>  
> +	if (cache_ops_need_broadcast())
> +		put_cpu();
> +
