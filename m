From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Mar 2014 10:39:02 +0000
Subject: [PATCH v6 00/14] uprobes: Add uprobes support for ARM
In-Reply-To: <20140303062324.GB20583@linux.vnet.ibm.com>
References: <1392017945-4507-1-git-send-email-dave.long@linaro.org>
 <20140301123026.GD21483@n2100.arm.linux.org.uk> <53131DBE.7020500@linaro.org>
 <20140303062324.GB20583@linux.vnet.ibm.com>
Message-ID: <20140303103902.GG21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 11:53:24AM +0530, Srikar Dronamraju wrote:
> I know there were more discussions on this, but I cant dig them out at
> this time.  Finally it was decided that
> 1. Users shouldnt have to select more than one config to select Uprobes.
> 2. There was no point in selecting Uprobes and not having Uprobe_event
> and vice versa.
> 
> >From the above, If a user chose UPROBE_EVENT, (which is the interface
> for uprobes), we would automatically assume that he wants to use Uprobes
> framework.

That much is fine - however, UPROBES itself is effectively not a user
selectable symbol, even today.  As I've already pointed it, it's
impossible for the user to select because it depends on UPROBE_EVENT,
but when UPROBE_EVENT is enabled, it's forced to be set to "y" meaning
that the user can't turn UPROBES off.

So, the UPROBES symbol has two states:
1. hidden, because its dependencies aren't satisfied.
2. force-y, because UPROBE_EVENT is enabled.

Hence, UPROBES itself serves no purpose.

Now, the solution you mentioned in:

	http://article.gmane.org/gmane.linux.kernel/1017186

looks entirely reasonable to me if there is the desire to keep the two
separate - but from what Frederic said in that post, it seems that there
isn't.

So I'd suggest just getting rid of this UPROBES symbol, moving the
dependency of PERF_EVENTS to UPROBE_EVENTS.  If another interface to
uprobes comes along, it can always be reintroduced in the manner you
suggested in the above.

Either solution should resolve the issue we're seeing on ARM with
David's patches.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
