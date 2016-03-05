From: tilman@imap.cc (Tilman Schmidt)
Date: Sat, 5 Mar 2016 14:08:39 +0100
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <1457108303.2651.112.camel@tiscali.nl>
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <1456945629-1793533-2-git-send-email-arnd@arndb.de>
 <56D7F62E.6050502@linux-pingi.de> <1659125.tHp8H942OG@wuerfel>
 <1457108303.2651.112.camel@tiscali.nl>
Message-ID: <56DADA57.9010200@imap.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 04.03.2016 um 17:18 schrieb Paul Bolle:
> [Added Tilman and Christoph.]
> 
> On vr, 2016-03-04 at 16:24 +0100, Arnd Bergmann wrote:
>> I actually did more patches that I ended up not submitting:
>>
>> * move hisax to staging
>> * remove i4l support from gigaset
> 
> For the record: I have no reason to object a patch that does that. (I'm
> not aware anyone complained when gigaset switched its default from i4l
> to capi. By now all relevant distributions should use our capi driver.)

No objection from me either. When the Gigaset driver is built for CAPI
it can still be used from i4l applications via capidrv with no loss of
functionality. That was a primary goal of the CAPI port.

>> * move i4l core to staging

That's a different story. Removing i4l support will actually remove a
userspace visible feature.

> On a local tree I have two (draft) patches that do some related
> preliminary work:
> - isdnhdlc: move into separate directory
> - mISDN: NETJet: stop selecting ISDN_I4L
> 
> These trivial patches untangle mISDN and i4l.

That would be a good thing regardless of any decision on the future of
the i4l userspace interface.

> For my part I'm surprised that anyone is still using it. But apparently
> the hardware that required commit 19cebbcb04c8 and 3460baa62068  (which
> I'm unfamiliar with) is still operational. And since there never has
> been, as far as I know, a global i4l to capi migration nor a global i4l
> (and capi) to mISDN migration it might be that some people are stuck on
> i4l drivers for their hardware. Perhaps that explains Cristoph's
> commits.

The trouble is that mISDN never cared about migration or backward
compatibility. So while users of i4l applications have no problem with
i4l drivers being ported to CAPI and dropping native i4l support, they
do have a problem with drivers making that move to mISDN.

That is the situation of the hisax driver today. mISDN started as a
project to migrate hisax to CAPI but regrettably dropped that goal in
favor of a newly invented API leaving old i4l based applications behind.
As a consequence, owners of HiSAX type adapters are in fact stuck with
the old hisax driver if they want to continue using i4l userspace tools.

In my opinion, i4l, capidrv and hisax need to stay in the supported part
for the time being as they are still actively used. Native i4l support
can and should be dropped for hardware with CAPI drivers (ie. gigaset)
but not for hardware with only mISDN drivers (ie. hisax). And finally,
ISDN_CAPI_CAPIDRV should be enabled automatically if both ISDN_I4L and
ISDN_CAPI are enabled, ie. something like:

--- a/drivers/isdn/capi/Kconfig
+++ b/drivers/isdn/capi/Kconfig
@@ -27,8 +27,8 @@ config ISDN_CAPI_MIDDLEWARE
          your ISP, say Y here.

 config ISDN_CAPI_CAPIDRV
-       tristate "CAPI2.0 capidrv interface support"
-       depends on ISDN_I4L
+       tristate
+       default ISDN_I4L
        help
          This option provides the glue code to hook up CAPI driven cards to
          the legacy isdn4linux link layer.  If you have a card which is


Jm2c,
Tilman

-- 
Tilman Schmidt                              E-Mail: tilman at imap.cc
Bonn, Germany
Nous, on a des fleurs et des bougies pour nous prot?ger.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160305/c183bc0e/attachment.sig>
