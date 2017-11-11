From: davem@davemloft.net (David Miller)
Date: Sat, 11 Nov 2017 19:23:07 +0900 (KST)
Subject: [PATCH net-next] net: thunderx: fix double free error
In-Reply-To: <20171109115859.23838-1-aleksey.makarov@cavium.com>
References: <20171109115859.23838-1-aleksey.makarov@cavium.com>
Message-ID: <20171111.192307.246949830866393163.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Aleksey Makarov <aleksey.makarov@cavium.com>
Date: Thu,  9 Nov 2017 14:58:57 +0300

> This patch fixes an error in memory allocation/freeing in
> ThunderX PF driver.
> 
> I moved the allocation to the probe() function and made it managed.
> 
> From the Colin's email:
> 
> While running static analysis on linux-next with CoverityScan I found 3
> double free errors in the Cavium thunder driver.
> 
> The issue occurs on the err_disable_device: label of function nic_probe
> when nic_free_lmacmem(nic) is called and a double free occurs on
> nic->duplex, nic->link and nic->speed.  This occurs when nic_init_hw()
> fails:
> 
>         /* Initialize hardware */
>         err = nic_init_hw(nic);
>         if (err)
>                 goto err_release_regions;
> 
> nic_init_hw() calls nic_get_hw_info() and this calls nic_free_lmacmem()
> if any of the allocations fail. This free'ing occurs again by the call
> to nic_free_lmacmem() on the err_release_regions exit path in nic_probe().
> 
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>

Applied, thank you.
