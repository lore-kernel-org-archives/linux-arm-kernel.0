From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 1 Dec 2015 12:22:12 -0500
Subject: [PATCH v2 1/2] scripts: Add a recorduidiv program
In-Reply-To: <20151201171014.GY8644@n2100.arm.linux.org.uk>
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-2-git-send-email-sboyd@codeaurora.org>
 <20151125234711.GT8644@n2100.arm.linux.org.uk>
 <565C6714.802@suse.com>
 <20151130153208.GR8644@n2100.arm.linux.org.uk>
 <565C6DE9.2020302@suse.com> <565DC5A9.2010305@suse.cz>
 <20151201161944.GX8644@n2100.arm.linux.org.uk>
 <20151201114929.655433a2@gandalf.local.home>
 <20151201171014.GY8644@n2100.arm.linux.org.uk>
Message-ID: <20151201122212.474afce5@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Dec 2015 17:10:14 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> Another suggestion - maybe recordmcount, which fstat()s the file,
> should check the st_nlink before modifying the file, and error out
> with a helpful error message telling people not to use hardlinks,
> which would stop nasty surprises (and make it a rule that this should
> be implemented as a general principle for good build behaviour) - iow,

Actually I like this solution the best.

> something like this (untested):

Can you test it to see if it gives you the error, otherwise I need to
set up a CCACHE_HARDLINK environment :-)

I guess another solution is to do a copy instead of modifying in place
if it detects the multiple hard link?

-- Steve


> 
>  scripts/recordmcount.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index 698768bdc581..bb7589fd7392 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -203,6 +203,10 @@ static void *mmap_file(char const *fname)
>  		fprintf(stderr, "not a regular file: %s\n", fname);
>  		fail_file();
>  	}
> +	if (sb.st_nlink != 1) {
> +		fprintf(stderr, "file is hard linked: %s\n", fname);
> +		fail_file();
> +	}
>  	addr = mmap(0, sb.st_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
>  		    fd_map, 0);
>  	mmap_failed = 0;
> 
> 
