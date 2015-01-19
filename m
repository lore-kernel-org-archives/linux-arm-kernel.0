From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Mon, 19 Jan 2015 20:59:59 +0200
Subject: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
In-Reply-To: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
Message-ID: <FDF8BE77-015A-41AD-A5FA-8FFB40AFDAE2@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> On Jan 19, 2015, at 20:55 , Wolfram Sang <wsa@the-dreams.de> wrote:
> 
> Back in the days, sysfs seemed to have refcounting issues and subsystems
> needed a completion to be safe. This is not the case anymore, so I2C can
> get rid of this code. There is noone else besides I2C doing something
> like this currently (checked with the attached coccinelle script which
> checks if a release function exists and if it contains a completion).
> 
> I have been digging through the history of linux.git and
> linux-history.git and found that e.g. w1 used to have such a mechanism
> and also simply removed it later.
> 
> Some more info from Greg Kroah-Hartman:
> "Having that call "wait" for the other release call to happen is really
> old, as Jean points out, from 2003.  We have "fixed" sysfs since then to
> detach the files from the devices easier, we used to have some nasy
> reference count issues in that area."
> 
> And some testing from Jean Delvare which matches my results:
> "However I just tested unloading an i2c bus driver while its adapter's
> new_device attribute was opened and rmmod returned immediately. So it
> doesn't look like accessing sysfs attributes actually takes a reference
> to the underlying i2c_adapter."
> 
> Let's get rid of this code before really nobody knows/understands
> anymore what this was for and if it has a subtle use.
> 

Hehe, rather obliquely tested by me too :)

Please save the reference counter hackers sanity and merge this :)

> Reported-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> ?
> 
Regards

? Pantelis
