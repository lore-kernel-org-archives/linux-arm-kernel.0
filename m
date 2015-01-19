From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 19 Jan 2015 11:17:02 +0800
Subject: [PATCH 18/28] PCI/sparc: Use pci_scan_root_bridge() for simplicity
In-Reply-To: <2658988.B0VmbMPdJ9@wuerfel>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
 <1421372666-12288-19-git-send-email-wangyijing@huawei.com>
 <2658988.B0VmbMPdJ9@wuerfel>
Message-ID: <54BC772E.6020103@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/16 18:01, Arnd Bergmann wrote:
> On Friday 16 January 2015 09:44:16 Yijing Wang wrote:
>> +static void pci_host_bridge_probe_mode(
>> +               struct pci_host_bridge *host)
>> +{
>> +       host->of_scan = true;
>> +}
>>
> 
> I probably missed something here, but where does host->of_scan
> get used?
> 

It is used in __pci_scan_root_bus() to detect whether of scan bus is needed in patch 11.


@@ -2051,10 +2053,17 @@ static struct pci_bus *__pci_scan_root_bus(
 		pci_bus_insert_busn_res(b, host->busnum, 255);
 	}

-	max = pci_scan_child_bus(b);
+	if (host->ops && host->ops->phb_probe_mode)
+		host->ops->phb_probe_mode(host);

-	if (!found)
-		pci_bus_update_busn_res_end(b, max);
+	if (host->of_scan) {
+		if (host->ops &&host->ops->phb_of_scan_bus)
+			host->ops->phb_of_scan_bus(host);
+	} else {
+		max = pci_scan_child_bus(b);
+		if (!found)
+			pci_bus_update_busn_res_end(b, max);
+	}

 	return b;

Thanks!
Yijing.


> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 


-- 
Thanks!
Yijing
