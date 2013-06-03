From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 3 Jun 2013 15:20:06 +0300
Subject: [GIT PULL] omap dss board clean-up for v3.10 merge window
In-Reply-To: <20130419184518.GA30836@quad.lixom.net>
References: <20130418033936.GC10155@atomide.com>
 <20130419184518.GA30836@quad.lixom.net>
Message-ID: <51AC89F6.1050308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 19/04/13 21:45, Olof Johansson wrote:
> Hi,
> 
> On Wed, Apr 17, 2013 at 08:39:37PM -0700, Tony Lindgren wrote:
>> The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
>>
>>   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/dss-signed
> 
> 
> Merged, but not happy about it.
> 
> As mentioned on IRC, I was going to let this one be until 3.11, but it sounds
> like it will cause regressions in DSS if we don't merge it.
> 
> This is an indication that the work wasn't done right on the DSS rework.
> Ideally the old configurations through platform_data should have been left in
> for a release to give the boards a window to convert over without regressing
> functionality. Tomi, please don't do it this way in the future since it's
> painful for everybody to deal with.

I have a somewhat similar situation again for 3.11 (or possibly for
3.12). I hope to hear from you what you think would be the best approach.

The background is that the omap display subsystem has a bunch of panel
drivers, and these drivers have used an OMAP DSS specific bus and driver
model. For various reasons I'm now converting the panel drivers to be
based on the panel's control bus, i.e. a panel controlled via i2c would
be an i2c device/driver, a panel not controlled at all would be a
platform device/driver, etc.

The work involves changing the omapdss driver, converting the panel
drivers to the new driver model, and changing the board files that use
the panel.

I see two main approaches to this:

1) Convert the panel drivers "in-place", i.e. have a commit which
changes a panel driver to the new model. This would mean that the
instant the commit is in, the boards using the panel do not work until
the board file has been changed.

2) Convert the panel to a new file, i.e. basically make a copy of the
panel driver while converting it. This way the boards using the old
panel drivers will continue working. (This is how I have my patches
currently organized).

Option 1) feels more natural, but if the arch and driver changes go
through separate trees, there's a piece of history during the merge
window where the displays won't work on the OMAP boards.

Option 2) allows us to keep the boards always functional if the new
panel drivers are merged in 3.11, and the board file changes are merged
in 3.12.

The downside is that it takes two kernel versions to get this in, and a
third kernel version to finally remove all the old code. 3.11 and 3.12
would contain unused code, some of which will be in the kernel image
(omapdss side changes) and some of which won't be compiled at all (the
new panel drivers).

Do you think option 2 and splitting the work into three kernel versions
is the way to go? Do you have some other ideas how to organize the merge
of these kind of changes?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130603/d2027662/attachment.sig>
