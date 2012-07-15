From: david@gibson.dropbear.id.au (David Gibson)
Date: Sun, 15 Jul 2012 17:39:19 +1000
Subject: Mis?use of aliases
In-Reply-To: <5001A745.3000509@firmworks.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
 <1342218413-30116-2-git-send-email-jon-hunter@ti.com>
 <5000D647.4090200@gmail.com> <50010402.3050502@firmworks.com>
 <20120714163701.GI11326@truffala.fritz.box>
 <5001A745.3000509@firmworks.com>
Message-ID: <20120715073919.GJ11326@truffala.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2012 at 07:07:17AM -1000, Mitch Bradley wrote:
> On 7/14/2012 6:37 AM, David Gibson wrote:
> > On Fri, Jul 13, 2012 at 07:30:42PM -1000, Mitch Bradley wrote:
> >>> I'm not sure this is really a good use of aliases. UARTs use aliases
> >>> because it is important that the UART number to tty number is known and
> >>> fixed.
> >>
> >> This brings up an issue that I've been meaning to comment on.
> >>
> >> The use of phandle-valued properties in the aliases node causes real OFW
> >> implementations some amount of heartburn.  The Open Firmware standard
> >> says that the properties in /aliases are string-valued.  That's
> >> important, because aliases are shorthand for fragments of full device
> >> specifiers (pathnames that can include arguments to nodes).  Phandles
> >> can point to nodes, but can't be relative, and can't encode
> >> per-node-component arguments.
> > 
> > Um, so, properties in /aliases should not have phandle values, flat
> > tree or otherwise.  Has this been seen in the wild, or are you being
> > misled by the fact that dtc's reference-to-phandle and
> > reference-to-path syntax is very similar:
> 
> Yes, I was indeed being misled.  Thanks for the clarification.  The
> "&fred" syntax is present in the .dts files that I have looked at.

Right, it's all about the context.  &label is always a reference to
another node, but in cell context < ... > that's expanded as a
phandle, in bare context it's expanded as a path.

> > 	prop = <&fred>;
> > Will generate a phandle valued property, but
> > 	prop = &fred;
> > Will generate a string (path) valued property.
> > 
> >> For binding a Linux unit number to a device node, I would prefer to
> >> decorate the node with a property like "linux,unit#", instead of
> >> breaking the standard semantics of /aliases.
> > 
> > I don't see how using aliases for unit numbering (inherently) breaks
> > the semantics of /aliases.  If phandle valued properties are being
> > used that is wrong, but it's not necessary for the unit numbering
> > anyway.
> 
> I agree, the use of string-valued /aliases is not a semantic problem.
> That said, I still think that decorating individual nodes is a better
> approach, for locality reasons.  But, now that my misunderstanding has
> been cleared up, it's a mild preference instead of "heartburn".

So, I think aliases was suggested for this sort of numbering precisely
because it _isn't_ local.  Particularly when numbering similar devices
across unrelated busses, the ordering more or less has to be a global
platform convention, and may not be derived from - or even contradict
- local numbering conventions from individual busses or components.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
