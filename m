From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 19 Jan 2011 10:43:02 +0000
Subject: RFC: Host-endian device tree format
Message-ID: <AANLkTi=AdwaW5vvm1TzNxcNrjYiJ3dOEjwoZrm-koxuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Apologies if this has been discussed before--- I don't see an obvious
rebuttal in my quick searching past threads, so I'll just quickly ask
the question:

Could we use host-endianness for the device tree binary blob?

The fdt binary format seems to lend itself strongly to a host-endian
format: it begins with a word-sized magic number, and when parsing the
device tree every elements type and size is known before that element
is read; furthermore, every element is size-aligned.  Therefore, I
(naively?) presume that a little-endian format should "just work",
simply by flipping the endianness of every element and discarding all
the __be32_to_cpu() type stuff when reading the fdt at boot time.  The
magic number ensures that there's no risk of accidentally reading the
fst in the wrong byte order.

Although it would be necessary to augment the fdt tools to cope with
this, offline tools appear to be the right place to put this
intelligence.  For the kernel to flip the byte order of everything in
the fdt blob every time the system boots just seems unnecessary when
the required endianness is statically known.

Since fdt is new on ARM we have an opportunity to change determine the
binary format now without breaking anything in the field -- we don't
necessarily have to adopt the host-endian format on any other
architectures if it's not desirable.

Any thoughts?

Cheers
---Dave
