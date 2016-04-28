From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Apr 2016 13:15:18 +0100
Subject: [PATCH v9 12/14] PM / Hibernate: Call flush_icache_range() on
 pages restored in-place
In-Reply-To: <1461775633-29715-13-git-send-email-james.morse@arm.com>
References: <1461775633-29715-1-git-send-email-james.morse@arm.com>
 <1461775633-29715-13-git-send-email-james.morse@arm.com>
Message-ID: <20160428121517.GF24693@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 05:47:11PM +0100, James Morse wrote:
> Some architectures require code written to memory as if it were data to be
> 'cleaned' from any data caches before the processor can fetch them as new
> instructions.
> 
> During resume from hibernate, the snapshot code copies some pages directly,
> meaning these architectures do not get a chance to perform their cache
> maintenance. Modify the read and decompress code to call
> flush_icache_range() on all pages that are restored, so that the restored
> in-place pages are guaranteed to be executable on these architectures.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  kernel/power/swap.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 12cd989dadf6..a30645d2e93f 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -37,6 +37,14 @@
>  #define HIBERNATE_SIG	"S1SUSPEND"
>  
>  /*
> + * When reading an {un,}compressed image, we may restore pages in place,
> + * in which case some architectures need these pages cleaning before they
> + * can be executed. We don't know which pages these may be, so clean the lot.
> + */
> +bool clean_pages_on_read = false;
> +bool clean_pages_on_decompress = false;

Should these be static?

Will
