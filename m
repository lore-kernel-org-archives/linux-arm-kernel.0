From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 06 Oct 2015 12:08:43 +0100
Subject: [PATCH 2/2] Convert smsc911x to use ACPI as well as DT
In-Reply-To: <D23813FF.33566%charles.garcia-tobin@arm.com>
References: <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
 <1443033714.74600.18.camel@infradead.org> <560310EA.2070805@intel.com>
 <1443042212.74600.30.camel@infradead.org> <56033C10.2040708@linaro.org>
 <1443082579.74600.48.camel@infradead.org>
 <20150924103152.GG13823@e104818-lin.cambridge.arm.com>
 <1443095558.74600.84.camel@infradead.org>
 <20150924151546.GJ13823@e104818-lin.cambridge.arm.com>
 <1443118238.74600.117.camel@infradead.org>
 <20150925152848.GQ13823@e104818-lin.cambridge.arm.com>
 <560C993D.8090308@redhat.com> <D23813FF.33566%charles.garcia-tobin@arm.com>
Message-ID: <1444129723.4674.236.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-10-05 at 17:20 -0700, Charles Garcia-Tobin wrote:
> it in ACPI circles
> unless we had wider agreement among OSs to use it. AFAIK PRP00001 has not
> actually been approved yet in the specification forum, and that it in
> itself is more of a concern for me,as the code has been pushed upstream.

Why would that be a concern? In that context it's just one device ID.
Individual devices don't *need* to be approved. OK, the 'PRP' vendor
prefix is not officially assigned but that's really a trivial piece of
bureaucracy.

> I guess it?s up to Catalin, but disabling for ARM seems like a good idea
> right now, another option is to add tests to FWTS.

I understand the motivation to avoid embracing a whole bunch of crappy
bindings. But I think that eschewing PRP0001 is the wrong technical
approach to achieving that.

It has false negatives ? as soon as you have a *single* existing DT
binding, perhaps something as simple as the serial port bindings from
the CHRP days, you'll be in a situation where you can't use that.
I've *got* hardware where I need to advertise a serial port with a
clock-frequency property because it *isn't* compatible with PNP0501.

And it has false positives ? there's nothing to prevent people from
doing ACPI-style bindings with crappy device bindings which also aren't
approved.

I think it's utterly na?ve to believe that simply avoiding the use of
PRP0001 + compatible for matching is going to have *any* significant
beneficial effect whatsoever. It only makes life harder for all
concerned.

Perhaps a better approach would be to introduce something like
CONFIG_UNAPPROVED_BINDINGS (which can't be set on ARM64), and those
drivers which use bindings that *aren't* approved by Catalin's crack
team of reviewers need to depend on !UNAPPROVED_BINDINGS. To be honest,
I still think even *that* is somewhat na?ve, but it's still a better
way of implementing what you're actually trying to achieve, however
optimistic you have to be to think it'll ever work in practice.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5691 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/8e51e461/attachment-0001.bin>
