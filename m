From: tj@kernel.org (Tejun Heo)
Date: Wed, 9 Jul 2014 09:59:10 -0400
Subject: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
In-Reply-To: <20140709082331.GA4510@kwain>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140708134000.GC4979@htj.dyndns.org>
 <20140708170353.GA16148@kwain>
 <20140708171817.GH4979@htj.dyndns.org>
 <20140708174900.GC16148@kwain>
 <20140708214010.GI4979@htj.dyndns.org>
 <20140709082331.GA4510@kwain>
Message-ID: <20140709135910.GA11193@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jul 09, 2014 at 10:23:31AM +0200, Antoine T?nart wrote:
> > It is confusing.  If you wanna pass around available ports in hpriv,
> > please add a separate field and replace the arguments to
> > save_initial_config().
> 
> I don't get it. Which argument should I replace in
> save_initial_config()? The change is we compute hpriv->port_map.
> I don't see which arguments we can add or replace.

The @force_port_map and @mask_port_map of ahci_save_initial_config().
We end up with three params from two places modifying port_map and one
of those is in/out parameter, so ummm, no.  If you wanna add port
masking to @hpriv, please do it by moving @force_port_map and
@mask_port_map into @hpriv instead.

Sure, the proposed change is small but the end result is messy.

> I had a quick look on this, and it does not seems to be that simple. The
> ahci_port_priv is stored inside the ata_port struct and not accessible
> (as of now) from the ahci_host_priv one. The ahci_port_priv is
> initialized at the end of ahci_platform_init_host(), far after we need
> it. This requires quite a lot of changes. Or is there another way?

Yeah, it'd probably need separating out port resource handling, so
that the order is get_resources, host_alloc, get_port_resources and
then init and activate.  Hans, what do you think?

> To be honest, we are now at v9 and it's been quite a long time since v1.
> I'd really like it to be merged in 3.17. As I see it, this patch keeps
> the same logic as what was in place before, only with more PHYs.
> 
> Don't take me wrong, I really think this is a good idea to have a
> per-port PHY information. But this is a refactoring not clearly related
> to this series as the logic is not changed. This definitively can be the
> subject of a dedicated series, especially if I got it right and the
> required modifications are not that obvious.

Heh, I get that but, at the same time, this is the point where you're
most motivated to actually work on it.  :)

Let's see how much work it's gonna be.

Thanks.

-- 
tejun
