From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 23 Jun 2015 22:28:50 +0200 (CEST)
Subject: [PATCH v6 3/9] nvmem: Add nvmem_device based consumer apis.
In-Reply-To: <1435014527-26265-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014527-26265-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1344600420.252283.1435091331020.JavaMail.open-xchange@oxbsltgw00.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 23. Juni 2015 um
> 01:08 geschrieben:
>
>
> This patch adds read/write apis which are based on nvmem_device. It is
> common that the drivers like omap cape manager or qcom cpr driver to
> access bytes directly at particular offset in the eeprom and not from
> nvmem cell info in DT. These driver would need to get access to the nvmem
> directly, which is what these new APIS provide.
>
> [...]
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 123af62..f9acc43 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -15,6 +15,15 @@
> struct device;
> /* consumer cookie */
> struct nvmem_cell;
> +struct nvmem_device;
> +
> +struct nvmem_cell_info {
> + const char *name;
> + int offset;
> + int bytes;
> + int bit_offset;
> + int nbits;
> +};
>
> #if IS_ENABLED(CONFIG_NVMEM)
>
> @@ -26,6 +35,21 @@ void devm_nvmem_cell_put(struct device *dev, struct
> nvmem_cell *cell);
> void *nvmem_cell_read(struct nvmem_cell *cell, ssize_t *len);
> int nvmem_cell_write(struct nvmem_cell *cell, void *buf, ssize_t len);
>
> +/* direct nvmem device read/write interface */
> +struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
> +struct nvmem_device *devm_nvmem_device_get(struct device *dev,
> + const char *name);
> +void nvmem_device_put(struct nvmem_device *nvmem);
> +void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem);
> +int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
> + size_t bytes, void *buf);
> +int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
> + size_t bytes, void *buf);

Maybe i mixed something but those functions use the datatype unsigned int for
offset
and the offset in the structs use datatype int. Looks a little bit inconsistent.
