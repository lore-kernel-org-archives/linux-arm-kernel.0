From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Thu, 10 Mar 2016 13:42:37 +0200
Subject: [PATCH 2/6] usb: xhci-mtk: use __maybe_unused to hide pm functions
In-Reply-To: <56D9B8EE.3060107@gmail.com>
References: <1456932255-71725-1-git-send-email-arnd@arndb.de>
 <1456932255-71725-3-git-send-email-arnd@arndb.de>
 <56D9B8EE.3060107@gmail.com>
Message-ID: <56E15DAD.3000104@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.03.2016 18:33, Matthias Brugger wrote:
>
>
> On 02/03/16 16:24, Arnd Bergmann wrote:
>> The mediatek XHCI glue driver uses SET_SYSTEM_SLEEP_PM_OPS() to
>> conditionally set the correct suspend/resume options, and
>> also puts both the dev_pm_ops and the functions inside of
>> an #ifdef testing for CONFIG_PM_SLEEP, but those functions
>> then call other code that becomes unused:
>>
>> drivers/usb/host/xhci-mtk.c:135:12: error: 'xhci_mtk_host_disable' defined but not used [-Werror=unused-function]
>> drivers/usb/host/xhci-mtk.c:313:13: error: 'usb_wakeup_enable' defined but not used [-Werror=unused-function]
>> drivers/usb/host/xhci-mtk.c:321:13: error: 'usb_wakeup_disable' defined but not used [-Werror=unused-function]
>>
>> This replaces the #ifdef with __maybe_unused annotations so the
>> compiler knows it can silently drop them instead of warning.
>>
>> For the DEV_PM_OPS definition, we can use an IS_ENABLED() check
>> to avoid defining the structure when CONFIG_PM is not set without
>> the #ifdef.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
