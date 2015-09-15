From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 15 Sep 2015 14:20:18 +0300
Subject: [PATCH] spmi-pmic-arb: support configurable number of peripherals
In-Reply-To: <55F77451.9070900@codeaurora.org>
References: <1442267672-11287-1-git-send-email-sboyd@codeaurora.org>
 <55F77451.9070900@codeaurora.org>
Message-ID: <1442316018.15519.4.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 2015-09-14 at 18:28 -0700, Stephen Boyd wrote:
> On 09/14/2015 02:54 PM, Stephen Boyd wrote:
> > The current driver implementation supports only 128 peripherals.
> > Add support for more than 128 peripherals by taking a lazy
> > caching approach to the mapping tables. Instead of reading the
> > tables at boot given some fixed size, read them on an as needed
> > basis and cache the results. We still assume a max number of 512
> > peripherals, trading off some space for simplicity.
> > 
> > Based on a patch by Gilad Avidov <gavidov@codeaurora.org> and
> > Sagar Dharia <sdharia@codeaurora.org>.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> 
> Hi Ivan,
> 
> This patch causes 8916 to crash, because there isn't a mapping for ppid
> 257 in the ppid to channel table. It seems that we're reading the revid
> from the slave id 1 pmic by going through channel 0, which seems to be
> setup for ppid 9 (slave id 0 and the peripheral starting at 0x900). Can
> we stop reading the revid registers from non-zero slave id pmic devices?
> That would be one solution to fix this problem. Or maybe we need to
> special case this in the pmic arbiter code to fold ppid 0xN01 (slave id
> N and address 0x100) onto channel 0 all the time?
> 

Yes, we can. We are not using this information at the moment.
Right now, revision read is more or less for debug purposes.

Would following patch work for you? Of course it will be difficult
to guaranties that some other driver misbehave and touch non-existing
register, right?

Regards,
Ivan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mfd-qcom-spmi-pmic-Do-not-access-non-existing-regist.patch
Type: text/x-patch
Size: 1392 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150915/40e07889/attachment.bin>
