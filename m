From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 12 Oct 2012 09:01:04 -0600
Subject: [PATCH 1/2] ARM: config: sort select statements alphanumerically
In-Reply-To: <20121012144832.GN28061@n2100.arm.linux.org.uk>
References: <20121012132553.GK28061@n2100.arm.linux.org.uk>
 <E1TMfFr-0001Kt-W5@rmk-PC.arm.linux.org.uk>
 <CACRpkdba1q52bEDcWsd47QwXA-DNhq6PENf2M-tvZ6znYu+5yw@mail.gmail.com>
 <20121012144119.GM28061@n2100.arm.linux.org.uk>
 <20121012144832.GN28061@n2100.arm.linux.org.uk>
Message-ID: <507830B0.1090709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2012 08:48 AM, Russell King - ARM Linux wrote:
> On Fri, Oct 12, 2012 at 03:41:20PM +0100, Russell King - ARM Linux wrote:
>> On Fri, Oct 12, 2012 at 04:04:28PM +0200, Linus Walleij wrote:
>>> On Fri, Oct 12, 2012 at 3:26 PM, Russell King
>>> <rmk+kernel@arm.linux.org.uk> wrote:
>>>
>>>> As suggested by Andrew Morton:
>>>>
>>>>   This is a pet peeve of mine.  Any time there's a long list of items
>>>>   (header file inclusions, kconfig entries, array initalisers, etc) and
>>>>   someone wants to add a new item, they *always* go and stick it at the
>>>>   end of the list.
>>>>
>>>>   Guys, don't do this.  Either put the new item into a randomly-chosen
>>>>   position or, probably better, alphanumerically sort the list.
>>>>
>>>> lets sort all our select statements alphanumerically.  This commit was
>>>> created by the following perl:
>>>
>>> I applied this and tried to configure the Nomadik defconfig,
>>> and I get this, sadly:
>>
>> Yes, I've just fixed those.  Unfortunately, the patch is soo large that
>> it trips the mailing list size limit, and has to be manually approved,
>> so I'm not sure I can call on the list maintainers again today to do the
>> approval thing.
> 
> Instead, here's the updated script:
> 
> 8<===
> #!/usr/bin/perl
> while (<>) {
> 	while (/\\\s*$/) {
> 		$_ .= <>;
> 	}
> 	undef %selects if /^\s*config\s+/;
> 	if (/^\s+select\s+(\w+).*/) {
> 		if (defined($selects{$1})) {
> 			if ($selects{$1} eq $_) {
> 				print STDERR "Warning: removing duplicated $1 entry\n";
> 			} else {
> 				print STDERR "Error: $1 differently selected\n".
> 					"\tOld: $selects{$1}\n".
> 					"\tNew: $_\n";
> 				exit 1;
> 			}
> 		}
> 		$selects{$1} = $_;
> 		next;
> 	}
> 	if (%selects and (/^\s*$/ or /^\s+help/ or /^\s+---help---/ or
> 			  /^endif/ or /^endchoice/)) {
> 		foreach $k (sort (keys %selects)) {
> 			print "$selects{$k}";
> 		}
> 		undef %selects;
> 	}
> 	print;
> }
> if (%selects) {
> 	foreach $k (sort (keys %selects)) {
> 		print "$selects{$k}";
> 	}
> }
> 8<===
> 
> Run it like this (assuming its saved as sort.pl):
> 
> for f in $(find arch/arm -name 'Kconfig*'); do perl sort.pl $f > $f.new \
> 	&& mv $f.new $f && git update-index $f; done
> 
> Omit the "git update-index" bit if you don't want to commit the result.
> ("git update-index" is safer than "git add" for this as "git add" will
> add new files, "git update-index" won't without an additional option.
> That's not a recommendation to use it though.)

FYI, I Tegra works fine after running this script. I guess you can
consider that an ack for the script output;

Acked-by: Stephen Warren <swarren@nvidia.com>
