From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 May 2015 15:26:55 +0100
Subject: [PATCH V2 5/6] regulator: add mxs on-chip regulator driver
In-Reply-To: <1973961885.66028.1432760281554.JavaMail.open-xchange@oxbsltgw06.schlund.de>
References: <1430346747-28728-6-git-send-email-stefan.wahren@i2se.com>
 <20150504123648.GU15510@sirena.org.uk>
 <1693367404.879766.1430771695242.JavaMail.open-xchange@oxbaltgw08.schlund.de>
 <1875749167.82542.1431023838932.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150507185216.GP22845@sirena.org.uk>
 <535744342.64563.1431026719818.JavaMail.open-xchange@oxbsltgw09.schlund.de>
 <20150507193236.GS22845@sirena.org.uk>
 <1290103954.26573.1432642616013.JavaMail.open-xchange@oxbsltgw08.schlund.de>
 <20150527173321.GH21577@sirena.org.uk>
 <1973961885.66028.1432760281554.JavaMail.open-xchange@oxbsltgw06.schlund.de>
Message-ID: <20150528142655.GX21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 10:58:01PM +0200, Stefan Wahren wrote:

> In case of a single driver instance instead of 4 ones (vddd, vddio, vdda,
> dc-dc), things would be much easier.

> Here are the steps for disabling DC-DC:

> 1. configure vddio to work without DC-DC
> 2. configure vdda to work without DC-DC
> 3. configure vddd to work without DC-DC
> 4. backup DC-DC settings
> 5. disable brownout detection
> 6. disable DC-DC
> 7. restore DC-DC settings

> My problem is that step 1 to 3 must be done step by step through the other
> regulator instances.

For the regulator API steps 1-3 aren't going to be needed since
dependency management means that we won't try to disable a regulator
that we think is in use.

> > If it's much more complicated than that
> > then I think putting a comment in the driver explaining what the issue
> > is would be the right step, that would address the issue with the driver
> > looking strange.

> Enabling or disabling DC-DC is only needed internally by the power subsystem
> (e.g. in case of handoff AC to battery), because the DC-DC only supplys the
> regulator daisy. From my understanding hardware components could use only the
> regulator outputs. In the end a state change is necessary, but it shouldn't be a
> public.

Should this actually be shown as a regulator then and not as part of the
power controller?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150528/3b54f5a5/attachment.sig>
