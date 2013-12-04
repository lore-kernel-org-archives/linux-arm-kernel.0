From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 09:56:05 +0100
Subject: [PATCH 02/31] ARM: tegra: document reset properties in DT bindings
In-Reply-To: <529E2781.5020504@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-3-git-send-email-swarren@wwwdotorg.org>
 <20131129122348.GO22771@ulmo.nvidia.com>
 <529B88C9.60804@wwwdotorg.org>
 <20131202090852.GD17834@ulmo.nvidia.com>
 <529E2781.5020504@wwwdotorg.org>
Message-ID: <20131204085605.GH19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 11:48:33AM -0700, Stephen Warren wrote:
> On 12/02/2013 02:08 AM, Thierry Reding wrote:
> > On Sun, Dec 01, 2013 at 12:06:49PM -0700, Stephen Warren wrote:
> >> On 11/29/2013 05:23 AM, Thierry Reding wrote:
> >>> On Fri, Nov 15, 2013 at 01:53:57PM -0700, Stephen Warren wrote:
> >>>  [...]
> >>>> diff --git 
> >>>> a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
> >>>>
> >>>> 
> b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
> >>> 
> >>>> 
> >> [...]
> >>>> +  - resets : Must contain an entry for each entry in 
> >>>> reset-names. +    See ../reset/reset.txt for details. +  - 
> >>>> reset-names : Must include the following entries: +    - dc
> >>> 
> >>> For consistency with this, the clock-names entry for the first 
> >>> clock in this node should then be "dc" as well.
> >> 
> >> The dc driver gets the clock by name, so this isn't a
> >> requirement.
> > 
> > Right, but like I've said in another reply, I'd very much like for
> > this to be fixed up so we don't have to mess around with
> > per-instance names for clocks. So instead of naming the first clock
> > in the display controller node "disp", we could rename it to "dc"
> > for consistency with the reset bindings.
> 
> I assume you're now OK with not changing the clock names, given my
> explanation?

No. Rather I hope that I was able to clarify what I was aiming for. To
illustrate with another example: if we were to mirror the naming of the
clocks for the resets, the nodes would look like this:

	dc at 54200000 {
		...
		clock-names = "disp1", "parent";
		...
		reset-names = "dc1";
	};

	dc at 54240000 {
		...
		clock-names = "disp2", "parent";
		...
		reset-names = "dc2";
	};

Rather than what I proposed, which would be either:

	dc at 54200000 {
		...
		clock-names = "disp", "parent";
		...
		reset-names = "dc";
	};

	dc at 54240000 {
		...
		clock-names = "disp", "parent";
		...
		reset-names = "dc";
	};

Or this:

	dc at 54200000 {
		...
		clock-names = "disp", "parent";
		...
		reset-names = "disp";
	};

	dc at 54240000 {
		...
		clock-names = "disp", "parent";
		...
		reset-names = "disp";
	};

Or even this:

	dc at 54200000 {
		...
		clock-names = "dc", "parent";
		...
		reset-names = "dc";
	};

	dc at 54240000 {
		...
		clock-names = "dc", "parent";
		...
		reset-names = "dc";
	};

The display controller driver doesn't request the first clock by name,
so it doesn't really matter what it's called, but "disp1" and "disp2"
are just wrong in my opinion.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/fd1d3cc1/attachment.sig>
