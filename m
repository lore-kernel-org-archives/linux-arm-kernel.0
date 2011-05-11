From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 May 2011 06:19:51 +0200
Subject: [PATCH 5/9] at91: use structure to store the current soc
In-Reply-To: <4DCA0CB8.6060205@bluewatersys.com>
References: <20110510162730.GA18929@game.jcrosoft.org>
	<1305045259-23066-5-git-send-email-plagnioj@jcrosoft.com>
	<4DC9B422.6070205@bluewatersys.com>
	<20110510234033.GB18929@game.jcrosoft.org>
	<4DC9DAAC.7060506@bluewatersys.com>
	<20110511032633.GG18929@game.jcrosoft.org>
	<4DCA0CB8.6060205@bluewatersys.com>
Message-ID: <20110511041951.GD22009@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:12 Wed 11 May     , Ryan Mallon wrote:
> On 05/11/2011 03:26 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 12:39 Wed 11 May     , Ryan Mallon wrote:
> >> On 05/11/2011 11:40 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>  
> >>>>> +
> >>>>> +static void soc_detect(u32 dbgu_base)
> >>>>> +{
> >>>>
> >>>> This looks far better than your previous patch, and is how I suggested
> >>>> it should have been done :-).
> >>>>
> >>>> I think possibly that this function should return an boolean indicating
> >>>> whether or not it was able to detect the cpu, rather than the calling
> >>>> function checking the internals of the at91_soc_data structure.
> >>> no need as at91_soc_data.type is init to SOC_AT91_NONE first
> >>> this ways we use less code
> >>
> >> Read the second part of my sentence. I think it is clearer/cleaner to
> >> have a return value specifying that the soc detection failed rather than
> >> checking the internals of the structure.
> > no the init of the struct is done on purpose to mach with the string table
> > and set as not detectd for type and subtype first
> > add a return to the soc detection just increase the code where the
> > information si already present in the structure
> 
> You are missing the point. You have a function called soc_detect which
> returns void. It modifies a structure called at91_soc_data (this is not
> obvious from looking just at the function declaration) and returns
no sorry it's very clear

at91 for the arch
soc_data data related to the soc

you can see 1000 times of time in the kernel
gic_data
cpu_data etc....

> information via that same structure (which again, is not clear to the
> casual observe looking just at the prototype or usage). If you have:
> 
> 	bool at91_soc_detect(struct at91_soc *soc);
> 
> Then it becomes more clear that the passed in soc pointer is what gets
> filled in, and the return value will be true or false depending on
> whether the soc was detected or not. It's not worth saving lines of code
> to make something less clear.
we have one soc no need to pass a pointer it's not a cpu where you can have
multiple one in a soc
> 
> >>
> >>>>
> >>>>> +		case ARCH_EXID_AT91SAM9M11:
> >>>>> +			at91_soc_data.subtype = SOC_SAM9M11;
> >>>>> +			break;
> >>>>> +		}
> >>>>
> >>>> If we reused the ARCH_EXID_ defines, then the above could become:
> >>>>
> >>>> 	at91_soc_data.subtype = at91_soc_data.exid;
> >>> as sais in the commint comment to have a uniq subtype accross soc as example
> >>> g35 and 9m11 have the same exid
> >>
> >> Why is this necessary? The cpu_is_macros, which are the _only_ way that
> >> the cpu/soc type should ever be checked, can do this. For example:
> >>
> >> #define cpu_is_at91sam9m11() \
> >> 	(at91_soc_data.type == ARCH_ID_AT91SAM9G45 &&
> >> 	 at91_soc_data.subtype == ARCH_EXID_AT91SAM9M11)
> >>
> >> This way you don't need any extra #defines, and the switch statements
> >> for the exid in soc_detect can be removed.
> >>
> >> This would also result in a smaller impact change since the cpu_is
> >> macros would still work exactly the same, just the method used to read
> >> the id and exid change.
> 
> > no more code and more assembly
> 
> Why?
two test to do everytime simple
compare to one
> 
> > furthermore we associate the subtype with the subtype name where each entry
> > are uniq
> 
> You could add:
> 
> 	const char *name;
> 	char *subtype_name;
> 
> To at91_soc_data. The name field can be directly assigned in the
> at91xxx.c files and the subtype name can be assigned when it is detected
> (which is why it can't be const). The removes the need for the
> type/subtype lookup tables.
no as we need to stock all the soc name here and it much more clear to get
them together and link to the enum type

and if the soc is not enable you can not have the name so impossible to inform
the user about which we detect and this will add too much ifdef

so no
> 
> 
> > 
> >>
> >>>>> +
> >>>>> +const char *get_at91_soc_type(struct at91_socinfo *c)
> >>>>> +{
> >>>>
> >>>> Should probably be called at91_get_soc_type_name. Get get_type implies
> >>>> it will return the enum type value. I think the at91 prefix belongs at
> >>>> the start also.
> >>>>
> >>>> Also, since at91_boot_soc is __initdata, the soc_name array should also
> >>>> be __initdata and this function should be __init.
> >>> no this data will be use for sysfs export later
> >>> and at91_soc_data is not __initdata
> >>
> >> Okay. I still think the function names should be changed.
> > we use the same convention on sh and it's clear for me
> 
> It is common for exported functions to be prefixed with the subsystem
> they belong to, in this case at91. Just because some other subsystem
> does it a different way doesn't mean we should repeat the mistake.
> 
> If you replace the type/subtype name lookup as I described above then
> it's moot anyway since you can just read at91_soc_data.name/subtype
> directly.
sorry I still not convince and keep the current naming convention
and replace the lookup will not work
> 
> >>
> >>>>
> >>>>> +
> >>>>> +	if (at91_soc_data.type == SOC_AT91_NONE)
> >>>>> +		panic("AT91: Impossible to detect the SOC type");
> >>>>> +
> >>>>> +	pr_info("AT91: Detected soc type: %s\n", get_at91_soc_type(&at91_soc_data));
> >>>>> +	pr_info("AT91: Detected soc subtype: %s\n", get_at91_soc_subtype(&at91_soc_data));
> >>>>> +
> >>>>> +	if (!at91_boot_soc.init)
> >>>>> +		panic("AT91: Soc not enabled");
> >>>>
> >>>> I would still like to see if it is possible to reorder these patches so
> >>>> that this intermediate rewrite is not needed.
> >>> there is none intermedaite write
> >>
> >> You snipped it out in the reply :-). Patch 2/9 adds soc detection in
> >> at91_map_io via a series of 'if (cpu_is_xxx)' statements. This patch
> >> then removes that method and replaces it with the switch statement in
> >> soc_detect. It would be nice to try and avoid the intermediate step in
> >> at91_map_io since it only exists for three commits.
> > no this two different changes with huge impact
> > first one factorize the map_io and change the AT91_BASE_SYS
> > 
> > so I do prefer to keep them seperated and bre able to bisect them
> 
> This patch could be made the first patch in the series since it doesn't
> (AFAICT) depend on AT91_BASE_SYS being generic since it uses internal
> defines for the two DBGU bases. So this patch would introduce an
> (possibly unused) soc_detection function, which can be put into use by
> the subsequent patches.
> 
> This would make the patch series easier to review since the change to
> move to soc detection only gets made once, not twice as it is now.

no I prefer to change the AT91_BASE_SYS first and touch the board
then add the real soc detection

The change of the memory must be first and it's impact alot of code

Best Regards,
J.
