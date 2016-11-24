From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 24 Nov 2016 10:47:31 +0000
Subject: [PATCH] SCPI (pre-v1.0): fix reading sensor value
In-Reply-To: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
References: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
Message-ID: <f3d6f39e-ec45-7c62-22d4-fd7b0952b499@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/11/16 00:18, Martin Blumenstingl wrote:
> I observed the following "strange" value when trying to read the SCPI
> temperature sensor on my Amlogic GXM S912 device:
> $ cat /sys/class/hwmon/hwmon0/temp1_input
> 6875990994467160116
>
> The value reported by the original kernel (Amlogic vendor kernel, after
> a reboot obviously) was 53C.
> The Amlogic SCPI driver only uses a single 32bit value to read the
> sensor value, instead of two. After stripping the upper 32bits from
> above value gives "52" as result, which is basically identical to
> what the vendor kernel reports.

Can you check why the upper 32-bit is not set to 0 ?

In scpi_process_cmd, we memset extra rx_buf length by 0 and that should
take care. Neil had mentioned that works but now I doubt if firmware
returns 8 instead of 4 in the size which is wrong as it supports only
32-bit.

-- 
Regards,
Sudeep
