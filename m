From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 23 Oct 2015 11:14:36 -0700
Subject: [PATCH] mtd: document linux-specific partition parser DT binding
In-Reply-To: <CACRpkdYboyXQ7tz8gSTafVLJy26E3qLAbcKyjOsEhh8j=3S1bQ@mail.gmail.com>
References: <1444915191-28350-1-git-send-email-linus.walleij@linaro.org>
 <20151015162210.GA4545@localhost>
 <CACRpkdYboyXQ7tz8gSTafVLJy26E3qLAbcKyjOsEhh8j=3S1bQ@mail.gmail.com>
Message-ID: <20151023181436.GL13239@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Fri, Oct 23, 2015 at 11:17:54AM +0200, Linus Walleij wrote:
> On Thu, Oct 15, 2015 at 6:22 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
> 
> > Are you trying to use this binding, or is this just purely a mechanical
> > documentation issue? I ask, because it seems that binding never really
> > got reviewed at all, and others have recently tried to extend support
> > for it generically [1], but a few objections came up [2][3].
> 
> I am using it in this devicetree patch:
> http://marc.info/?l=linux-arm-kernel&m=144492610417605&w=2
> 
> And this devicetree patch:
> http://marc.info/?l=linux-arm-kernel&m=144490455308758&w=2
> 
> Otherwise the AFS partition type will not be scanned.
> 
> The other option is to add "afs" to this list in
> drivers/mtd/maps/physmap_of.c:
> 
> diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
> index 3e614e9119d5..6233473a55d6 100644
> --- a/drivers/mtd/maps/physmap_of.c
> +++ b/drivers/mtd/maps/physmap_of.c
> @@ -110,7 +110,7 @@ static struct mtd_info *obsolete_probe(struct
> platform_device *dev,
>     default is use. These take precedence over other device tree
>     information. */
>  static const char * const part_probe_types_def[] = {
> -       "cmdlinepart", "RedBoot", "ofpart", "ofoldpart", NULL };
> +       "cmdlinepart", "RedBoot", "ofpart", "ofoldpart", "afs", NULL };
> 
> I can send a patch like this if you prefer?

Hmm, not really. While I'd love to have a good common set of reasonably
generic partition parsers that we could always run on all MTDs (or in
this case, all physmap_of MTDs) similar to how the block subsystem does
it, I don't think that is really workable here, as there is too much
variation in parsers and mamy of them actually scan the whole flash (or
at least, the headers of each block). This can get very expensive, and
potentially leaves room for false matches, especially when you start
layering on all the other potential parsers others might want to use.

IOW, this solution is not scalable IMO. In previous discussions, I think
we've agreed that partition parsing must be informed by platform
knowledge.

> > Unfortunately I/we dropped the ball a bit on that thread, but we'd
> > ideally like to address those concerns in a new binding that is
> > supported for all MTDs, and deprecate the old one. The new one would
> > probably not directly use the parser name as used by Linux, but define
> > some list of compatible strings that fit DT conventions better. Also, I
> > don't want people including things like "cmdlinepart" in DT, but it
> > should be available as an override if necessary. IOW, DT shouldn't
> > supersede the kernel command line.
> 
> This is not for cmdlinepart, as AFS is an actual on-flash format.

Right. I was just mentioning that this binding:

  (1) allows people to specify nonsensical things like "ofpart" and
  "cmdlinepart" in their DT and
  (2) allows people to specify DTs that *don't* allow developer
  overrides like cmdlinepart (e.g., the partition layout is corrupted,
  so we want to boot a recovery kernel with a predetermined
  'mtdparts=...' parameter)

Neither is directly related to your use of AFS, but it's just part of my
thoughts on codifying the use of this binding.

> > That's not to say we can't document the old one, but I'm curious if
> > there are real users. I'd also like to encourage new users to avoid the
> > old one if we can make that feasible.
> 
> I'm happy to do either patch, or define a new binding if you
> prefer, like simply:

I would prefer a new binding. And personally, I'd like to get something
like this extended to all MTDs (there are other users asking for similar
things), but I haven't made the time to write the patch :(

> partition-type = <string>;
> 
> and then we define this as "arm,arm-flash-structure" or something,
> and parse that to "afs" internally in physmap_of.c.

Seems OK to me. Again, I'd prefer this not live in physmap_of.c, but if
that's the expedient solution, I could probably take it from there.

> >> + - linux,part-probe: a flash partition type to look for, using the
> >> +   Linux-internal partition naming scheme, e.g. "afs" for the ARM
> >> +   Flash footers.
> >
> > IIUC, this property actually supports a list of parsers, not just a
> > single partition type.
> 
> Ah it does. If we wanna go with this patch I'll fix it.

I'd rather not take this patch if we can safely pivot to an improved
binding, but I'm not sure if that violates the DT policy party line :)

> > Also, if we're really going to support this, we should list exactly what
> > strings we support. And that's one of the problems with the existing
> > binding; it supports any old string Linux supports, which doesn't match
> > how we typically want to add bindings (i.e., via proposal + review).
> 
> OK that sounds like a case for "arm,arm-flash-structure" for this
> specific binding.

Right.

Brian
