From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2015 19:14:28 +0000
Subject: device_node lifetime (was: Re: [PATCH 1/7] phy: brcmstb-sata:
 add missing of_node_put)
In-Reply-To: <CAL_JsqLQWh8-gshYLrYwrrRjBRXiOACh9LzVn2HUU38mfgYGoQ@mail.gmail.com>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447673600-8881-2-git-send-email-Julia.Lawall@lip6.fr>
 <20151117013830.GV8456@google.com>
 <alpine.DEB.2.02.1511170711340.2045@localhost6.localdomain6>
 <20151117174430.GA8456@google.com>
 <alpine.DEB.2.10.1511171846120.2455@hadrien>
 <20151117183036.GF8456@google.com>
 <alpine.DEB.2.02.1511172327030.2121@localhost6.localdomain6>
 <20151118190500.GE140057@google.com>
 <CAL_JsqLQWh8-gshYLrYwrrRjBRXiOACh9LzVn2HUU38mfgYGoQ@mail.gmail.com>
Message-ID: <20151119191428.GB8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 12:44:11PM -0600, Rob Herring wrote:
> On Wed, Nov 18, 2015 at 1:05 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
> > (changing subject, add devicetree at vger.kernel.org)
> >
> > On Tue, Nov 17, 2015 at 11:33:25PM +0100, Julia Lawall wrote:
> >> On Tue, 17 Nov 2015, Brian Norris wrote:
> >> > On Tue, Nov 17, 2015 at 06:48:39PM +0100, Julia Lawall wrote:
> >> > > Is this something that should be checked for elsewhere?
> >> >
> >> > I expect the same sort of problem shows up plenty of other places. I
> >> > don't think many people use CONFIG_OF_DYNAMIC, so the effects of these
> >> > failures probably aren't felt by many.
> 
> The "problem" is non-existent because either CONFIG_OF_DYNAMIC is off
> or where it is used is limited (memory and cpus on PSeries) and now
> overlays. Overlays have the potential to be problematic, but we should
> manage ref counting for overlays in a completely different way. What
> that looks like, I don't know. I'll leave that to the person that
> cares about removing overlays.

So are you saying we should just forget about of_node_put and delete all
of_node_put/of_node_get references in code outside drivers/of ?  That
seems pretty obtuse given that we do have the overlay code merged, and
sounds to me like a very bad idea.

Expecting those who want to use overlays to run around checking that
the refcounting is correct in drivers is a really silly idea IMHO -
the existing API is refcounted, so either people really ought to be
using it correctly as it's already been designed (in other words, with
correct refcounting, and we shouldn't be shovelling this problem onto
other people) or the refcounting should be completely killed.

The existing half-way house of "we have refcounting, but we don't care
about it" is really insane.

Either we have refcounting, and it's used properly, or we don't have
refcounting.  No middle ground IMHO.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
