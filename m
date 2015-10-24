From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Sat, 24 Oct 2015 15:58:17 +0200
Subject: [PATCH V1 10/10] acpi, gicv3, its: Use MADT ITS subtable to do
 PCI/MSI domain initialization.
In-Reply-To: <562B5B6E.2000305@huawei.com>
References: <1444917919-21152-1-git-send-email-tn@semihalf.com>
 <1444917919-21152-11-git-send-email-tn@semihalf.com>
 <562B5B6E.2000305@huawei.com>
Message-ID: <562B8E79.6010701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2015 12:20 PM, Hanjun Guo wrote:
> On 2015/10/15 22:05, Tomasz Nowicki wrote:
>> After refactoring DT code, we let ACPI to build ITS PCI MSI domain
>> and do requester ID to device ID translation using IORT table.
>>
>> We have now full PCI MSI domain stack, thus we can enable ITS initialization
>> from GICv3 core driver for ACPI scenario.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its-pci-msi.c | 48 ++++++++++++++++++++++++++++++--
>>   drivers/irqchip/irq-gic-v3.c             |  3 +-
>>   2 files changed, 47 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> index cfd35da..09ae2d8 100644
>> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> @@ -15,6 +15,8 @@
>>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>    */
>>
>> +#include <linux/acpi.h>
>> +#include <linux/iort.h>
>>   #include <linux/msi.h>
>>   #include <linux/of.h>
>>   #include <linux/of_irq.h>
>> @@ -59,8 +61,10 @@ static int its_pci_msi_vec_count(struct pci_dev *pdev)
>>   static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
>>   {
>>   	struct its_pci_alias *dev_alias = data;
>> +	u32 dev_id;
>>
>> -	dev_alias->dev_id = alias;
>> +	dev_alias->dev_id = iort_find_pci_id(pdev, alias, &dev_id) == 0 ?
>> +								dev_id : alias;
>
> Hi tomasz, I think we need to re work this patch on top of tip/irq/core
> which has support for "msi-map" and "mai-parent" property support.
>

Indeed, I will rebase after some more comments related to other patches 
in this series.

Tomasz
