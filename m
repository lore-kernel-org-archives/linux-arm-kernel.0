From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Nov 2015 12:53:35 -0800
Subject: [RFC/PATCH 2/3] recordmcount: Record locations of
 __aeabi_{u}idiv() calls on ARM
In-Reply-To: <20151121101349.GI8644@n2100.arm.linux.org.uk>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <1448068997-26631-3-git-send-email-sboyd@codeaurora.org>
 <20151121101349.GI8644@n2100.arm.linux.org.uk>
Message-ID: <20151123205335.GD19156@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21, Russell King - ARM Linux wrote:
> On Fri, Nov 20, 2015 at 05:23:16PM -0800, Stephen Boyd wrote:
> > @@ -452,14 +631,14 @@ static char const *
> >  __has_rel_mcount(Elf_Shdr const *const relhdr,  /* is SHT_REL or SHT_RELA */
> >  		 Elf_Shdr const *const shdr0,
> >  		 char const *const shstrtab,
> > -		 char const *const fname)
> > +		 char const *const fname, const char *find)
> >  {
> >  	/* .sh_info depends on .sh_type == SHT_REL[,A] */
> >  	Elf_Shdr const *const txthdr = &shdr0[w(relhdr->sh_info)];
> >  	char const *const txtname = &shstrtab[w(txthdr->sh_name)];
> >  
> > -	if (strcmp("__mcount_loc", txtname) == 0) {
> > -		fprintf(stderr, "warning: __mcount_loc already exists: %s\n",
> > +	if (strcmp(find, txtname) == 0) {
> > +		fprintf(stderr, "warning: %s already exists: %s\n", find,
> 
> Oh, it's this which has been spewing that silly
> 	"warning: __mcount_loc already exists"
> 
> message thousands of times in my nightly kernel builds (so much so, that
> I've had to filter the thing out of the logs.)  Given that this is soo
> noisy, I think first we need to get to the bottom of why this program is
> soo noisy before we try to make it more functional.
> 

This comment in recordmcount.pl may tell us something.

	#
	# Somehow the make process can execute this script on an
	# object twice. If it does, we would duplicate the mcount
	# section and it will cause the function tracer self test
	# to fail. Check if the mcount section exists, and if it does,
	# warn and exit.
	#
	print STDERR "ERROR: $mcount_section already in $inputfile\n" .
	    "\tThis may be an indication that your build is corrupted.\n" .
	    "\tDelete $inputfile and try again. If the same object file\n" .
	    "\tstill causes an issue, then disable CONFIG_DYNAMIC_FTRACE.\n";
	exit(-1);

I don't think there's much that can be done here besides making
it silent unless there's some verbose build flag set (-v?), but
it is interesting that you see it spew thousands of times. I've
never seen the error printed, but perhaps I'm not building the
kernel the same way you are. Care to share how you're building
and seeing these error messages?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
