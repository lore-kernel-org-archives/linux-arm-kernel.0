From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 27 Jun 2011 18:19:55 +0530
Subject: [PATCH v3 02/12] OMAP2+: UART: Remove uart clock handling code
	from serial.c
In-Reply-To: <877h8ax3ss.fsf@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-3-git-send-email-govindraj.raja@ti.com>
	<877h8ax3ss.fsf@ti.com>
Message-ID: <BANLkTim1fEnfqu4KaN6FkG_CT93=joZC_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2011 at 3:58 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Cleanup serial.c file in preparation to addition of runtime api's in omap-serial
>> file. Remove all clock handling mechanism as this will be taken care with
>> pm runtime api's in omap-serial.c file itself.
>>
>> 1.) Remove omap-device enable and disable. We can can use get_sync/put_sync api's
>> 2.) Remove context save/restore can be done with runtime_resume callback for
>> ? ? get_sync call. No need to save context as all reg details available in
>> ? ? uart_port structure can be used for restore, so add missing regs in
>> ? ? uart port struct.
>> 3.) Add func to identify console uart.
>> 4.) Erratum handling informed as flag to driver and func to handle erratum
>> ? ? can be moved to omap-serial driver itself.
>>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> [...]
>
>> @@ -47,65 +40,9 @@
>> ?#include "control.h"
>> ?#include "mux.h"
>>
>> -#define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV ?0x52
>> -#define UART_OMAP_WER ? ? ? ? ? ? ? ?0x17 ? ?/* Wake-up enable register */
>> -
>> -#define UART_ERRATA_FIFO_FULL_ABORT ?(0x1 << 0)
>> -#define UART_ERRATA_i202_MDR1_ACCESS (0x1 << 1)
>> -
>> -/*
>> - * NOTE: By default the serial timeout is disabled as it causes lost characters
>> - * over the serial ports. This means that the UART clocks will stay on until
>> - * disabled via sysfs. This also causes that any deeper omap sleep states are
>> - * blocked.
>> - */
>> -#define DEFAULT_TIMEOUT 0
>> -
>> -#define MAX_UART_HWMOD_NAME_LEN ? ? ? ? ? ? ?16
>> +#define MAX_UART_HWMOD_NAME_LEN ? ? ? ? ? ? ? ?16
>
> Minor: only whitespace change here, you converted tabs to spaces.

yes, will correct this.

--
Govindraj.R

>
> Rest of this looks fine.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
