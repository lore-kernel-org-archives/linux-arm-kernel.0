From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 11 Mar 2015 11:16:31 +0800
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <20150310094142.GD24885@pengutronix.de>
References: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
 <1425888603-25800-3-git-send-email-s.hauer@pengutronix.de>
 <7h61a94zy0.fsf@deeprootsystems.com>
 <20150310094142.GD24885@pengutronix.de>
Message-ID: <1426043791.24243.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2015-03-10 at 10:41 +0100, Sascha Hauer wrote:
> On Mon, Mar 09, 2015 at 02:35:03PM -0700, Kevin Hilman wrote:
> > Sascha Hauer <s.hauer@pengutronix.de> writes:
> > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > A bit of a changelog here would be useful describing this driver, that
> > it's only covering part of the device (e.g. power controller) with more
> > to come, dependency on the syscon driver, etc.
> > 
> > > +/*
> > > + * The Infracfg unit has bus protection bits. We enable the bus protection
> > > + * for disabled power domains so that the system does not hang when some unit
> > > + * accesses the bus while in power down.
> > > + */
> > 
> > Hmm, why don't you want to know if some device is accessing another
> > device which is in a domain that is powered down?   Seems like this is a
> > good way to hide real bugs.
> 
> How I understand it the system just hangs on erroneous accesses without
> these protection bits enabled, so enabling them at least makes sure we
> can output something.
> I must admit though that my understanding of these bits is quite limited
> and the only user of this driver I have available here (audio) doesn't
> make use of these protection bits, so I can't test here.
> 
> James, could you shed some light on this issue?

I asked our designer about the bus protection feature, here is his
response:

"
It's for unexpected signal glitch in Power switch process.

During Power switch process, we have clock switch, reset, isolation
enable/disable and  power switch involved where the transition of
asynchronous reset and  isolation is the most critical one,  which have
risk to introduce a unexpected short period signal transition from
MTCMOS?s interface to other alive HW . 
"

That means it protects unexpected bus accessing from HW, not from SW. So
it will not hide bugs from wrong SW access.


Best regards,

James

************* Email Confidentiality Notice ********************
The information contained in this e-mail message (including any 
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be 
conveyed only to the designated recipient(s). Any use, dissemination, 
distribution, printing, retaining or copying of this e-mail (including its 
attachments) by unintended recipient(s) is strictly prohibited and may 
be unlawful. If you are not an intended recipient of this e-mail, or believe 
that you have received this e-mail in error, please notify the sender 
immediately (by replying to this e-mail), delete any and all copies of 
this e-mail (including any attachments) from your system, and do not
disclose the content of this e-mail to any other person. Thank you!
