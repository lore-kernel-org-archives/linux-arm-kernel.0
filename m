From: tj@kernel.org (Tejun Heo)
Date: Wed, 19 Feb 2014 12:42:03 -0500
Subject: [PATCH v6 00/18] ahci: library-ise ahci_platform, add sunxi
 driver and cleanup imx driver
In-Reply-To: <5304E751.5040608@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <20140219150249.GG10134@htj.dyndns.org>
 <5304CD33.1080704@redhat.com>
 <20140219162511.GJ10134@htj.dyndns.org>
 <5304E751.5040608@redhat.com>
Message-ID: <20140219174203.GM10134@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 06:18:09PM +0100, Hans de Goede wrote:
> Most of the resources are already devres managed (I use devm functions
> to get them), the problem is not in freeing our reference to the resources,
> the problem is that we've sequences like this:
> 
> devm_get_foo
> enable_foo
> disable_foo
> (automatic release foo)
> 
> Where enable / disable can be done repeatedly (ie each suspend / resume).
> 
> From your review comments, I take it that you want the final disable_foo
> on driver release to happen automatically.
> 
> My preference for this would be to extend the devres tracking already present
> in the relevant subsystems to keep track of the enable count done through a
> specific reference, to allow automatic disable (if needed) on release.
> 
> But thinking more about this, I think that doing this automatically is a bad
> idea, because then we fixate the shutdown sequence to a certain order (the
> order in which we did the _get_foo for the resources) and the correct order may
> be device specific.
> 
> So TL;DR: Yes to making things so that ahci_platform_put_resources gets done
> automatically, no to automating the disable calls.
> 
> If I don't hear back from you, then I'll respin the patch-set assuming that
> you agree to the above.

Yeah, sounds good enough to me.

Thanks.

-- 
tejun
