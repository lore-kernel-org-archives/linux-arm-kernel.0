From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 20 Jul 2012 10:42:49 +0100
Subject: Boot breaks in -next from LEGACY to LINEAR conversion
In-Reply-To: <CACxGe6utvV6XbJEck_UuVJxsqckPFZXG3psEgeQ1vZSBGAwm9Q@mail.gmail.com>
References: <20120717185749.GJ4477@opensource.wolfsonmicro.com>
 <20120718161023.GE4495@opensource.wolfsonmicro.com>
 <CACxGe6utvV6XbJEck_UuVJxsqckPFZXG3psEgeQ1vZSBGAwm9Q@mail.gmail.com>
Message-ID: <20120720094248.GM4495@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 10:30:11PM -0600, Grant Likely wrote:

> Okay, I've got a theory about what the issue is now. The .map()
> callback is failing (returning non-zero) for one of the hwirqs. The
> new code is stricter about associations, and actually unwinds the
> associations if one of them fails. The old legacy code simply called
> all the .map() hooks blindly without any error checking. Can you send
> me the kernel log after backing out those changes.

Looks like the error checking is the issue.  Always knew that was a bad
idea :)  I've just sent a patch to improve the diagnostics here which
might help a bit, though I realise now with some of my debug I need to
send a v2 :/ .

On my system there's only one mapping failed, but it's for one of the
VIC mappings which is rather unfortunate.  The error is there because
the VIC is returning -ENOTSUPP to skip invalid IRQs which doesn't
immediately seem like an awful thing to do for generic code like this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120720/e8c18b18/attachment-0001.sig>
