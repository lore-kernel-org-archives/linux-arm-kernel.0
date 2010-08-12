From: konkers@android.com (Erik Gilling)
Date: Wed, 11 Aug 2010 17:31:00 -0700
Subject: [PATCH] spi: add spi_tegra driver
In-Reply-To: <AANLkTimUm_wj+gyxTa=X+845kLj1sZ9GF+jsmsBwxnLN@mail.gmail.com>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<AANLkTimUm_wj+gyxTa=X+845kLj1sZ9GF+jsmsBwxnLN@mail.gmail.com>
Message-ID: <AANLkTinKNfPtaYYyUMmdTRewSKiRnTEfaf+pKkx_7jME@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 31, 2010 at 11:21 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> What is the status of the APB DMA driver? ?Is it going to be merged in 2.6.36?

Since we were too late on these patches, they will go into the 37
merge window.  The APB DMA driver will go in then along with SPI.

>> + * drivers/spi/spi_tegra.c
>
> I find it is more useful, and it is my preference, to have a one-line
> description of what the file actually is here. ?Showing the filename
> is just redundant and doesn't tell a reader anything new.

I'll change it so it matches the rest of the files in the directory

>> +#define DRIVER_NAME ? ? ? ? ? ?"spi_tegra"
>
> Used only twice in 2 side-by-side locations. ?I'd trim, or at least
> move to where it is actually used.

done


>> +#define BUSY_TIMEOUT ? ? ? ? ? 1000
>
> Used exactly once. ?May be better defined and documented at the usage site

done

>> +
>> +static inline unsigned bytes_per_word(u8 bits)
>> +{
>> + ? ? ? WARN_ON((bits < 1) || bits > 32);
>
> This condition has already been tested for in spi_tegra_start_transfer()
>
>> + ? ? ? if (bits <= 8)
>> + ? ? ? ? ? ? ? return 1;
>> + ? ? ? else if (bits <= 16)
>> + ? ? ? ? ? ? ? return 2;
>> + ? ? ? else if (bits <= 24)
>> + ? ? ? ? ? ? ? return 3;
>> + ? ? ? else
>> + ? ? ? ? ? ? ? return 4;
>
> return ((bits - 1) / 8) + 1
>
> Also, this function is used in exactly 1 place. ?Consider moving it
> down to nearer where it is called, or open coding it instead.

moved to spi_tegra_start_transfer

>> +static unsigned long spi_readl(struct spi_tegra_data *tspi, unsigned long reg)
>
> To avoid global namespace collisions, please prefix all static symbols
> with something like tegra_spi_.

changed

>> +{
>> + ? ? ? return readl(tspi->base + reg);
>> +}
>> +
>> +static void spi_writel(struct spi_tegra_data *tspi, unsigned long val,
>> + ? ? ? ? ? ? ? ? ? ? ?unsigned long reg)
>> +{
>> + ? ? ? writel(val, tspi->base + reg);
>> +}
>
> Are the accessor redirects really necessary? ?Is there any likelyhood
> that anything other than readl/writel will ever be used to access the
> device regs?

They are there to make reset of the code easier to read and less error
probe by eliminating the tspi->base + reg from every call.

>> +
>> + ? ? ? speed = t->speed_hz ? t->speed_hz : spi->max_speed_hz;
>> + ? ? ? bits_per_word = t->bits_per_word ? t->bits_per_word ?:
>> + ? ? ? ? ? ? ? spi->bits_per_word;
>> +
>> + ? ? ? if (bits_per_word < 1 || bits_per_word > 32)
>> + ? ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? ? if (t->len == 0)
>> + ? ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? ? if (!t->rx_buf && !t->tx_buf)
>> + ? ? ? ? ? ? ? return -EINVAL;
>
> Looks to me like this validation should be performed before accepting
> the transfer (see comments below)

moved


>> + ? ? ? ? ? ? ? tspi->cur = ?list_first_entry(&tspi->cur->transfer_list,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_transfer,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? transfer_list);
>> + ? ? ? ? ? ? ? spi_tegra_start_transfer(spi, tspi->cur);
>
> Not checking the returned error code. ?If an error occurs, then the
> callback needs to be called to notify that the message did not
> complete. ?However, this comment may be moot if the validation is
> moved out of spi_tegra_start_transfer().

moved


>> +static int spi_tegra_transfer(struct spi_device *spi, struct spi_message *m)
>> +{
>> + ? ? ? struct spi_tegra_data *tspi = spi_master_get_devdata(spi->master);
>> + ? ? ? unsigned long flags;
>> + ? ? ? int was_empty;
>> +
>> + ? ? ? if (list_empty(&m->transfers) || !m->complete)
>> + ? ? ? ? ? ? ? return -EINVAL;
>
> It's a good idea to move most of the validation of the message from
> spi_tegra_start_message() and spi_tegra_start_transfer() to here so
> that the validation occurs outside of the spinlock. ?It also means the
> driver doesn't discover badly formed messages part way through the
> transfer.

moved

>> + ? ? ? if (!request_mem_region(r->start, (r->end - r->start) + 1,
>> + ? ? ? ? ? ? ? ? ? ? ? dev_name(&pdev->dev))) {
>> + ? ? ? ? ? ? ? ret = -EBUSY;
>> + ? ? ? ? ? ? ? goto err0;
>> + ? ? ? }
>
> I believe the platform bus does this for you already by calling
> insert_resource() on all the platform bus ranges. ?See if /proc/iomem
> is any different with or without this call to verify.

You're right.  Didn't realize this


>> +static int __exit spi_tegra_remove(struct platform_device *pdev)
>
> __devexit

done

>> + ? ? ? r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + ? ? ? release_mem_region(r->start, (r->end - r->start) + 1);
>
> Ditto to comment earlier.

done


>> + ? ? ? .remove = ? ? ? __exit_p(spi_tegra_remove),
>
> __devexit_p

done


>> +subsys_initcall(spi_tegra_init);
>
> Is module_init() not sufficient?

All the other spi drivers use subsys_initcall

New patch coming soon.

Thanks,
    Erik
