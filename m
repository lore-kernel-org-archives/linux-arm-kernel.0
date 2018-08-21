From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 21 Aug 2018 14:34:44 +0100
Subject: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
In-Reply-To: <20180821133136.1fada1b6@bbrezillon>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl> <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock> <20180819184609.6dcdbb9a@bbrezillon>
 <20180821005327.0d312a85@tock> <20180821074404.23aaeb6b@bbrezillon>
 <81407b4d-a02f-4085-f333-a96102bd96ce@linaro.org>
 <20180821133136.1fada1b6@bbrezillon>
Message-ID: <6fb36da4-c985-6d6e-f9e1-572f5cd7609b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/08/18 12:31, Boris Brezillon wrote:
>>     * struct nvmem_config - NVMEM device configuration
>> @@ -58,6 +62,7 @@ struct nvmem_config {
>>           bool                    root_only;
>>           nvmem_reg_read_t        reg_read;
>>           nvmem_reg_write_t       reg_write;
>> +       nvmem_match_t           match;
>>           int     size;
>>           int     word_size;
>>           int     stride;
>>
> That might work if nvmem cells are defined directly under the mtdnode.
Layout should not matter! which is the purpose of this callback.

The only purpose of this callback is to tell nvmem core that the 
node(nvmem cell) belongs to that provider or not, if it is then we 
successfully found the provider. Its up to the provider on which layout 
it describes nvmem cells. Additionally the provider can add additional 
sanity checks in this match function to ensure that cell is correctly 
represented.


> If we go for this approach, I'd recommend replacing this ->match() hook
> by ->is_nvmem_cell() and pass it the cell node instead of the nvmem
> node, because what we're really after here is knowing which subnode is
> an nvmem cell and which subnode is not.

I agree on passing cell node instead of its parent. Regarding basic 
validating if its nvmem cell or not, we can check compatible string in 
nvmem core if we decide to use "nvmem-cell" compatible.

Also just in case if you missed this, nvmem would not iterate the

--srini
