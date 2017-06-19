From: enrico.weigelt@gr13.net (Enrico Weigelt, metux IT consult)
Date: Mon, 19 Jun 2017 08:27:00 +0200
Subject: imx6: efficient buffer copy from fpga
Message-ID: <7f67c820-095f-da10-27c9-760ade569cd9@gr13.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,


I'd like to know your opinions on the most efficient way of copying
from an fpga (w/ some ADCs) to ram buffers within the kernel. The
fpga (XC7A50T) is attached w/ only 16 bits.

When just using memcpy(), I'd suspect the copied data will be padded
to 32bit (and need to copy the double size of the fpga's buffer).
The actual ADC samples are 24bit (in two subsequent 16bit words),
and interleaved for 3 ADCs - IOW: the buffer holds a sequence of
records, where each record is a sequnce of three samples, one for
each ADC channel.

>From CPU view (32bit) it would look something like that:
(with padding due to fpga's 16bit word)

struct sample {
	u16 low;
        u16 _pad0;
        u16 high;
	u16 _pad1;
};

struct record {
	struct sample chan0;
	struct sample chan1;
	struct sample chan2;
};

struct buffer {
	[ ... ]
	struct sample samples[NUM_SAMPLES];
	[ ... ]
};

(maybe we could change fpga to have separate sample arrays per
channel, and therefore 3 of them in the buffer, w/ some padding)

Finally, I need feed them into the IIO buffers (I'd guess feed the
samples one by one would cause a lot overhead, so it should be done
in bigger blocks).

What would be the most efficient approach for that ?
Is there some memcpy() variant that can handle that conversion ?

OTOH, the imx6 has an sdma controller - could that be used via
dma engine for that ? (we have buffers of 64kb, one active for
receiving new sample, the other one passive for transfer to cpu,
one a rx buffer is filled, they switch roles and an intr is raised)



thx.

--mtx

--
Enrico, Sohn von Wilfried, a.d.F. Weigelt,
metux IT consulting
+49-151-27565287
