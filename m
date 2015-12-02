From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 2 Dec 2015 09:05:17 -0500
Subject: [PATCH v2 1/2] scripts: Add a recorduidiv program
In-Reply-To: <20151202102339.GB8644@n2100.arm.linux.org.uk>
References: <20151125234711.GT8644@n2100.arm.linux.org.uk>
 <565C6714.802@suse.com>
 <20151130153208.GR8644@n2100.arm.linux.org.uk>
 <565C6DE9.2020302@suse.com> <565DC5A9.2010305@suse.cz>
 <20151201161944.GX8644@n2100.arm.linux.org.uk>
 <20151201114929.655433a2@gandalf.local.home>
 <20151201171014.GY8644@n2100.arm.linux.org.uk>
 <20151201122212.474afce5@gandalf.local.home>
 <20151201181643.GZ8644@n2100.arm.linux.org.uk>
 <20151202102339.GB8644@n2100.arm.linux.org.uk>
Message-ID: <20151202090517.432556a4@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Dec 2015 10:23:39 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Tue, Dec 01, 2015 at 06:16:43PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Dec 01, 2015 at 12:22:12PM -0500, Steven Rostedt wrote:  
> > > I guess another solution is to do a copy instead of modifying in place
> > > if it detects the multiple hard link?  
> > 
> > That would be the "transparent" solution.  If you think it's worth
> > persuing, I'll have a go at fixing recordmcount to do that.  
> 
> Well, copying the file is easy - I've tested this and the linker
> appears happy with the result:

Want to make this into a proper patch and I'll start running it through
my tests?

-- Steve

> 
>  scripts/recordmcount.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index 698768bdc581..91705ef30402 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -211,6 +211,20 @@ static void *mmap_file(char const *fname)
>  		addr = umalloc(sb.st_size);
>  		uread(fd_map, addr, sb.st_size);
>  	}
> +	if (sb.st_nlink != 1) {
> +		/* file is hard-linked, break the hard link */
> +		close(fd_map);
> +		if (unlink(fname) < 0) {
> +			perror(fname);
> +			fail_file();
> +		}
> +		fd_map = open(fname, O_RDWR | O_CREAT, sb.st_mode);
> +		if (fd_map < 0) {
> +			perror(fname);
> +			fail_file();
> +		}
> +		uwrite(fd_map, addr, sb.st_size);
> +	}
>  	return addr;
>  }
>  
> 
