From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 20 Nov 2012 16:51:56 +0000
Subject: [PATCH 1/3] OF: Add helper for matching against linux, stdout-path
In-Reply-To: <20121119095202.GL4398@game.jcrosoft.org>
References: <1352971866-540-1-git-send-email-s.hauer@pengutronix.de>
 <1352971866-540-2-git-send-email-s.hauer@pengutronix.de>
 <20121119095202.GL4398@game.jcrosoft.org>
Message-ID: <20121120165156.395713E102F@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2012 10:52:02 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> On 10:31 Thu 15 Nov     , Sascha Hauer wrote:
> > devicetrees may have a linux,stdout-path property in the chosen
> > node describing the console device. This adds a helper function
> > to match a device against this property so a driver can call
> > add_preferred_console for a matching device.
> 
> I like it but I've an issue with it I cannot specify the option for
> 
> as example I need to set the uart at 38400n8 or 115200n8 regarless of wath the
> booloader did

Right. stdout-path can have a set of arguments appended for things like
serial speed.  ePAPR says this about stdout-path:

A string that specifies the full path to the node representing the
device to be used for boot console output. If the character ":" is
present in the value it terminates the path. The value may be an alias.

If the stdin-path property is not specified, stdout-path should be
assumed to define the input device.

So, this function needs to do three more things:
- also look for 'stdout-path' (in addition to 'linux,stdout-path')
- Parse for a ':' in the path and trim that off so it can be used for
  arguments. (Bonus: return the arguments to the caller)
- make sure that it can handle the path containing an alias (I've just
  not checked if the current code will handle this)

g.
