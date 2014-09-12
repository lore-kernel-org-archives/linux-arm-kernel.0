From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Sep 2014 10:26:20 -0700
Subject: [PATCH/RESEND] tty: serial: msm: Add DT based earlycon support
In-Reply-To: <CAL_JsqLtx9+P1-O+gVRRhpjntHuNQZp4ASV8ScBhZB7gWDsGFw@mail.gmail.com>
References: <1410473644-19103-1-git-send-email-sboyd@codeaurora.org>
 <CAL_JsqLtx9+P1-O+gVRRhpjntHuNQZp4ASV8ScBhZB7gWDsGFw@mail.gmail.com>
Message-ID: <54132CBC.6030003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/14 18:56, Rob Herring wrote:
> On Thu, Sep 11, 2014 at 5:14 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> Add support for DT based early console on platforms with the msm
>> serial hardware.
>>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> One comment, but looks good to me.
>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks.

>> +static int __init
>> +msm_serial_early_console_setup(struct earlycon_device *device, const char *opt)
>> +{
>> +       if (!device->port.membase)
>> +               return -ENODEV;
>> +
>> +       device->con->write = msm_serial_early_write;
>> +       return 0;
>> +}
>> +OF_EARLYCON_DECLARE(msm_serial, "qcom,msm-uart",
>> +                   msm_serial_early_console_setup);
> Don't you want to support kernel command line as well? Then if you
> can't change the DT or bootloader's command line, you can add it into
> the kernel build with the appended command line. Don't forget to
> document it in kernel-parameters.txt if you do.
>
>

Ok. Here's the interdiff. I'll send a v2.

---8<----
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 5ae8608ca9f5..22302931e9d4 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -936,6 +936,18 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			must already be setup and configured. Options are not
 			yet supported.
 
+		msm_serial,<addr>
+			Start an early, polled-mode console on an msm serial
+			port at the specified address. The serial port
+			must already be setup and configured. Options are not
+			yet supported.
+
+		msm_serial_dm,<addr>
+			Start an early, polled-mode console on an msm serial
+			dm port at the specified address. The serial port
+			must already be setup and configured. Options are not
+			yet supported.
+
 		smh	Use ARM semihosting calls for early console.
 
 	earlyprintk=	[X86,SH,BLACKFIN,ARM,M68k]
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index d3881991e8d3..4b6c78331a64 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -976,6 +976,7 @@ msm_serial_early_console_setup(struct earlycon_device *device, const char *opt)
 	device->con->write = msm_serial_early_write;
 	return 0;
 }
+EARLYCON_DECLARE(msm_serial, msm_serial_early_console_setup);
 OF_EARLYCON_DECLARE(msm_serial, "qcom,msm-uart",
 		    msm_serial_early_console_setup);
 
@@ -997,6 +998,7 @@ msm_serial_early_console_setup_dm(struct earlycon_device *device,
 	device->con->write = msm_serial_early_write_dm;
 	return 0;
 }
+EARLYCON_DECLARE(msm_serial_dm, msm_serial_early_console_setup_dm);
 OF_EARLYCON_DECLARE(msm_serial_dm, "qcom,msm-uartdm",
 		    msm_serial_early_console_setup_dm);
 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
