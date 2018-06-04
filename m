From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 4 Jun 2018 15:20:14 +0100
Subject: [RFC PATCH 7/8] dts: coresight: Define new bindings for direction
 of data flow
In-Reply-To: <20180601203928.GD9838@xps15>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-8-git-send-email-suzuki.poulose@arm.com>
 <20180601203928.GD9838@xps15>
Message-ID: <c38e4b05-622e-8747-dee4-990cfbe7633d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2018 09:39 PM, Mathieu Poirier wrote:
> On Fri, Jun 01, 2018 at 02:16:06PM +0100, Suzuki K Poulose wrote:
>> So far we have relied on an undocumented property "slave-mode",
>> to indicate if the given port is input or not. Since we are
>> redefining the coresight bindings, define new property for the
>> "direction" of data flow for a given connection endpoint in the
>> device.
>>
>> Each endpoint must define the following property.
>>
>>   - "direction" : 0 => Port is input
>> 		 1 => Port is output
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/of_coresight.c | 20 ++++++++++++++++----
> 
> You haven't documented the binding in bindings/arm/coresight.txt the same way
> you did with "coresight,hwid".  I'm guessing you simply forgot to do a "git add"
> on the file when preparing the patchset.
> 
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
>> index 99d7a9c..63c1668 100644
>> --- a/drivers/hwtracing/coresight/of_coresight.c
>> +++ b/drivers/hwtracing/coresight/of_coresight.c
>> @@ -52,7 +52,19 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
>>   			       endpoint, of_dev_node_match);
>>   }
>>   
>> -static void of_coresight_get_ports(const struct device_node *node,
>> +static bool of_coresight_ep_is_input(struct device *dev, struct device_node *ep_node)
> 
> I suggested of_coresight_endpoint_get_port_id() in my review of 6/8.  I'm good
> with either "ep" or "endpoint", as long as the names are consistent.

Yep, that's right. This is what I have for the documentation :

--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -103,9 +103,11 @@ with a specific direction of data flow, each 
connection must define the
  following properties to uniquely identify the connection details.

   * Direction of the data flow w.r.t the component :
-   Each input port must have the following property defined at the 
"endpoint"
+   Each hardware port must have the following property defined at the 
"endpoint"
     for the port.
-       "slave-mode"
+       "direction" - 32bit integer, whose values are defined as follows :
+               0 => the endpoint is an Input port
+               1 => the endpoint is an Output port.


and changes to the examples as well..


Cheers
Suzuki
