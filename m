From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 10 Mar 2015 08:43:22 +0100
Subject: [PATCH 05/15] musb: Do not use musb_read[b|w] / _write[b|w]
 wrappers in generic fifo functions
In-Reply-To: <4821047.1nqnop93Xh@wuerfel>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
 <1425933628-9672-6-git-send-email-hdegoede@redhat.com>
 <4821047.1nqnop93Xh@wuerfel>
Message-ID: <54FEA09A.6040401@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09-03-15 22:50, Arnd Bergmann wrote:
> On Monday 09 March 2015 21:40:18 Hans de Goede wrote:
>> The generic fifo functions already use non wrapped accesses in various
>> cases through the iowrite#_rep functions, and all platforms which override
>> the default musb_read[b|w] / _write[b|w] functions also provide their own
>> fifo access functions, so we can safely drop the unnecessary indirection
>> from the fifo access functions.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>
> The patch looks reasonably, but the description seem misleading.
> I believe the real reason why it's ok to use __raw_writew for the
> FIFO is that a FIFO by definition is using CPU endian access for
> copying byte streams from memory, which is unlike any other MMIO
> register that requires fixed-endian accessors.

I'm not sure that that is the case here, this fifo allows reading
4 bytes at a time using 32 bit word access, so endianness may come
into play. This patch is safe however since all existing users of
the generic fifo_read / write helpers which this patch touches, are
also using the generic musb_read[b|w] / _write[b|w] functions which
are just __raw_foo wrappers, so there is no functional change, which
is what the commit message tries to say.

Note that sunxi needs this function because of the register address
translation the sunxi_musb_readb / writeb wrappers are doing which
does not know how to deal with fifo data, and besides that it should
make the generic read / write fifo helpers somewhat faster by removing
an indirect function call.

Regards,

Hans
