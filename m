From: randy.dunlap@oracle.com (Randy Dunlap)
Date: Thu, 03 Jun 2010 09:32:50 -0700
Subject: [PATCH 2/2] menuconfig: truncate list items
In-Reply-To: <4C0758C9.7080108@cn.fujitsu.com>
References: <4C0758B7.5070907@cn.fujitsu.com> <4C0758C9.7080108@cn.fujitsu.com>
Message-ID: <4C07D932.4040404@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/10 00:24, Li Zefan wrote:
> Truncate list items to fit in a single line, otherwise those items
> which have long prompts will cover some other items.
> 
> This follows the behavior of menubox.
> 
> Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>

Thanks :)

Tested-by: Randy Dunlap <randy.dunlap@oracle.com>

Ben, the Samsung S3C24* prompt still gets truncated with this patch (when using
an 80-column wide xterm).  If you care about seeing all of the models,
you might want to shorten the prompt.


> ---
>  scripts/kconfig/lxdialog/checklist.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
> index c92a05a..a2eb80f 100644
> --- a/scripts/kconfig/lxdialog/checklist.c
> +++ b/scripts/kconfig/lxdialog/checklist.c
> @@ -31,6 +31,10 @@ static int list_width, check_x, item_x;
>  static void print_item(WINDOW * win, int choice, int selected)
>  {
>  	int i;
> +	char *list_item = malloc(list_width + 1);
> +
> +	strncpy(list_item, item_str(), list_width - item_x);
> +	list_item[list_width - item_x] = '\0';
>  
>  	/* Clear 'residue' of last item */
>  	wattrset(win, dlg.menubox.atr);
> @@ -45,13 +49,14 @@ static void print_item(WINDOW * win, int choice, int selected)
>  		wprintw(win, "(%c)", item_is_tag('X') ? 'X' : ' ');
>  
>  	wattrset(win, selected ? dlg.tag_selected.atr : dlg.tag.atr);
> -	mvwaddch(win, choice, item_x, item_str()[0]);
> +	mvwaddch(win, choice, item_x, list_item[0]);
>  	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
> -	waddstr(win, (char *)item_str() + 1);
> +	waddstr(win, list_item + 1);
>  	if (selected) {
>  		wmove(win, choice, check_x + 1);
>  		wrefresh(win);
>  	}
> +	free(list_item);
>  }
>  
>  /*


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
