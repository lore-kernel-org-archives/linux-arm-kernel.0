From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Sat, 24 Mar 2018 09:42:24 +0300
Subject: sun6i spi driver issue
Message-ID: <16d32ee2-886a-a169-a1a8-f05ee6a09a66@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the following patch [1] isn't working on my BPi M2, OPi PC, OPi PC+. I 
have no more boards to test currently but I am sure it will fail on 
others too. As soon as the max transfer size is set to a value MORE THAN 
FIFO then most of transfers would end up with -110 (timeout).

[1] https://patchwork.kernel.org/patch/9634315/

I have reverted the patch back in my local kernel and it works well on 
all the boards mentioned. It works fine too without subtracting 1 byte 
from FIFO, i.e. one could use the code below:

static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
{
 ??????? struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);

 ??????? return sspi->fifo_depth;
}

Thanks
