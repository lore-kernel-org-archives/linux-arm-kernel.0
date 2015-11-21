From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2015 10:13:50 +0000
Subject: [RFC/PATCH 2/3] recordmcount: Record locations of
 __aeabi_{u}idiv() calls on ARM
In-Reply-To: <1448068997-26631-3-git-send-email-sboyd@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <1448068997-26631-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151121101349.GI8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 05:23:16PM -0800, Stephen Boyd wrote:
> @@ -452,14 +631,14 @@ static char const *
>  __has_rel_mcount(Elf_Shdr const *const relhdr,  /* is SHT_REL or SHT_RELA */
>  		 Elf_Shdr const *const shdr0,
>  		 char const *const shstrtab,
> -		 char const *const fname)
> +		 char const *const fname, const char *find)
>  {
>  	/* .sh_info depends on .sh_type == SHT_REL[,A] */
>  	Elf_Shdr const *const txthdr = &shdr0[w(relhdr->sh_info)];
>  	char const *const txtname = &shstrtab[w(txthdr->sh_name)];
>  
> -	if (strcmp("__mcount_loc", txtname) == 0) {
> -		fprintf(stderr, "warning: __mcount_loc already exists: %s\n",
> +	if (strcmp(find, txtname) == 0) {
> +		fprintf(stderr, "warning: %s already exists: %s\n", find,

Oh, it's this which has been spewing that silly
	"warning: __mcount_loc already exists"

message thousands of times in my nightly kernel builds (so much so, that
I've had to filter the thing out of the logs.)  Given that this is soo
noisy, I think first we need to get to the bottom of why this program is
soo noisy before we try to make it more functional.

I had assumed that this message was produced by something in the
toolchain, not something in the kernel.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
