From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jan 2013 15:00:01 +0000
Subject: ERROR: "__aeabi_uldivmod" [drivers/pinctrl/pinctrl-single.ko]
 undefined!
Message-ID: <20130111150001.GA23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

The above error happens in builds including pinctrl-single - the reason
is this, where resource_size_t may be 64-bit.

                gpio->range.pin_base = (r.start - pcs->res->start) / mux_bytes;
                gpio->range.npins = (r.end - r.start) / mux_bytes + 1;

This leads to a 64-bit division by an extended 64-bit, resulting in the
call to our (unimplemented) 64-bit-by-64-bit division routines.

This needs fixing - you probably want to cast the difference down to an
'unsigned' first, and also maybe check that it does fit in an unsigned
too?
