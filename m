From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 15 Feb 2013 22:55:14 +0000
Subject: [PATCH RESEND 4/6 v13] gpiolib: Fix default attributes for class
In-Reply-To: <1358250716-21986-5-git-send-email-stigge@antcom.de>
References: <1358250716-21986-1-git-send-email-stigge@antcom.de>
 <1358250716-21986-5-git-send-email-stigge@antcom.de>
Message-ID: <20130215225514.8D54B3E15F8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Jan 2013 12:51:54 +0100, Roland Stigge <stigge@antcom.de> wrote:
> There is a race condition between creating a gpio or gpiochip device and adding
> default attributes. This patch fixes this by defining the default attributes as
> dev_attrs of the class. For this, it was necessary to create a separate
> gpiochip_class besides gpio_class.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Hi Roland,

Yup, that's a bug. Thanks for looking at this. Unfortunately creating a
new class creates a new problem because it changes the userspace ABI
(the gpiochip simlinks move to a different class directory).

Instead, I think the correct solution here is to use (struct device *)->groups
to add attributes to a device. Unfortunately that means that
create_device() won't work anymore. It does some useful setup work
though that I don't want to have to reproduce. You could create a
variant that also allows groups to be set, or you could factor out the
allocation/setup stuff so we can do an allocate/fixup/register sequence.

g.
