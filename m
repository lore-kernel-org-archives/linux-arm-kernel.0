From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 7 Dec 2012 17:02:15 +0000
Subject: [PATCH 0/6 v10] gpio: Add block GPIO
In-Reply-To: <50C1DE21.8050709@antcom.de>
References: <1354830456-17590-1-git-send-email-stigge@antcom.de>
 <20121207103643.34ca6dc5@pyramind.ukuu.org.uk>
 <50C1DBD4.1040007@antcom.de> <50C1DE21.8050709@antcom.de>
Message-ID: <20121207170215.0057f791@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 07 Dec 2012 13:16:33 +0100
Roland Stigge <stigge@antcom.de> wrote:

> On 12/07/2012 01:06 PM, Roland Stigge wrote:
> > On 12/07/2012 11:36 AM, Alan Cox wrote:
> >>> * Device interface for userland access (alternative to sysfs)
> >>
> >> Currently we can set different permissions on different GPIO lines. Your
> >> driver change drives a truck through this facility.
> 
> What I maybe misread in your concern: The dev interface is actually an
> "alternative to sysfs for block GPIO", not considered as a replacement
> for the current sysfs interface for _single_ GPIOs.

That is the problem. If you add the driver then you can no longer
implement the same permissions per node. If I've got a typical hardened
embedded device running something like SMACK I can tie a few gpio lines
to specific tasks in the security model.

The moment there is another driver anyone who can open that driver can
bypass all the security rules being imposed.

The basic problem is that right now our mapping is

"gpio line is a file system object"

you change it to

"all gpio lines are a single file system object"

Thats a bit like moving from "each document has permissions" to "allo my
documents have one permission set between them"

That makes it a very big step backwards and a fundamental change to the
entire auth model. It's not too horrendous in the case that the block
GPIO interface is the least restrictive case, but its very bad the
other way around.

The problem isn't the block API, the problem is changing the entire file
system level view of what a GPIO is and how it is access controlled.

Alan
