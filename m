From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Fri, 4 Oct 2013 08:47:05 +0200
Subject: [PATCH v3 net-next] fix unsafe set_memory_rw from softirq
In-Reply-To: <1380853446-30537-1-git-send-email-ast@plumgrid.com>
References: <1380853446-30537-1-git-send-email-ast@plumgrid.com>
Message-ID: <20131004064705.GA4143@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 07:24:06PM -0700, Alexei Starovoitov wrote:
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 7092392..a5df511 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -881,7 +881,9 @@ void bpf_jit_free(struct sk_filter *fp)
>  	struct bpf_binary_header *header = (void *)addr;
> 
>  	if (fp->bpf_func == sk_run_filter)
> -		return;
> +		goto free_filter;
>  	set_memory_rw(addr, header->pages);
>  	module_free(NULL, header);
> +free_filter:
> +	kfree(fp);
>  }

For the s390 part:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
