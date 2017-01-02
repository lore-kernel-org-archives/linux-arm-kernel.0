From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Jan 2017 14:06:54 +0000
Subject: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
In-Reply-To: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170102140654.GF14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2016 at 05:01:02PM +0530, Bhumika Goyal wrote:
> The object armada38x_rtc_ops of type rtc_class_ops structure is not
> modified after getting initialized by armada38x_rtc_probe. Apart from
> getting referenced in init it is also passed as an argument to the function
> devm_rtc_device_register but this argument is of type const struct
> rtc_class_ops *. Therefore add __ro_after_init to its declaration.

What I'd prefer here is for the structure to be duplicated, with one
copy having the alarm methods and one which does not.  Both can then
be made "const" (so placed into the read-only section at link time)
and the probe function select between the two.

I think that's a cleaner and better solution, even though it's
slightly larger.

I'm not a fan of __ro_after_init being used where other solutions are
possible.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
